# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  login                  :string(255)
#  name                   :string(255)
#  surname                :string(255)
#  admin                  :boolean(1)      default(FALSE)
#  enabled                :boolean(1)
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:user_login]

  # Virtual attribute for sign with email or login
  attr_accessor :user_login, :password_confirmation, :current_password

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :login, :surname, :name, :user_login, :current_password, :admin, :enabled, :group_ids


  # Relationships
  has_many :created_catalogs, class_name: 'Catalog', foreign_key: 'created_by'
  has_many :catalogs, as: :catalogable
  has_and_belongs_to_many :groups
  has_many :projects, through: :groups

  # PreSave actions
  before_save { |user| user.email = email.downcase }

  #validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  validates :login, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  public

  def full_name
    self.name + " " + self.surname
  end

  private
  # Overides devise method to allow authentication by users email or login
    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if user_login = conditions.delete(:user_login)
        where(conditions).where(["lower(login) = :value OR lower(email) = :value", { :value => user_login.downcase }]).first
      else
        where(conditions).first
      end
    end
end

