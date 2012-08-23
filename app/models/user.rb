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
                  :login, :surname, :name, :user_login, :current_pass

  # Relationships
  has_many :catalogs

  # PreSave actions
  before_save { |user| user.email = email.downcase }

  #validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  validates :login, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  public

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

