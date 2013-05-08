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

  include HasMessages
  include CatalogExtension
  has_many :messages

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:user_login]

  model_stamper

  easy_roles :roles
  ROLES = %w[project_manager group_manager]


  # Virtual attribute for sign with email or login
  attr_accessor :user_login, :password_confirmation, :current_password

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :login, :surname, :name, :user_login, :current_password, :admin, :enabled, :group_ids, :groups_users_attributes, :roles

  # Relationships
  has_many :created_catalogs, class_name: 'Catalog', foreign_key: 'creator_id'
  has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id'
  has_many :created_projects, class_name: 'Project', foreign_key: 'creator_id'
  has_many :created_dicoms, class_name: 'DicomFile', foreign_key: 'creator_id'
  has_many :catalogs, as: :catalogable
  has_many :groups_users, dependent: :destroy
  has_many :groups, through: :groups_users
  has_many :projects, through: :groups, group: :project_id
  has_many :permissions
  has_one :root_catalog, class_name: "Catalog", as: :catalogable, conditions: { ancestry: nil }

  accepts_nested_attributes_for :groups_users

  # PreSave actions
  before_save { |user| user.email = email.downcase }

  after_create :create_root_catalog

  #validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  validates :login, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  public

  def root_catalog_id
    self.root_catalog.id
  end


  def list_roles
    self.roles.join(" ").humanize.titleize
  end

  def full_name
    self.name + " " + self.surname
  end

  def shares_with_group?(group)
    groups_users.where(group_id: group).first.share
  end

  def has_permission?(action, resource)
    ids = resource.class.to_s == "Group" ? resource.id : resource.groups.pluck("groups.id")
    permissions.where(action: action, permissionable_type: 'Group', permissionable_id: ids).limit(1).exists?
  end




  def send_message?(options)
    send_message(options)
    true
  rescue Exception => e
    false
  end

  def send_message(options)
    unless options[:recipients].nil?
      transaction do

        recipients = options[:recipients]
        options.delete(:recipients)

        options[:subject_id] = Message.sequence_subject_id if options[:subject_id].nil?

        recipients.each do |rec|
          # => create message copies
          options[:user_id] = self.id
          options[:sender_id] = self.id
          options[:recipient_id] = rec.id
          options[:copies] = true
          Message.create(options)
          # => create message
          options[:user_id] = rec.id
          options[:sender_id] = self.id
          options[:recipient_id] = rec.id
          options[:copies] = false
          options[:parent_id] = Message.next_parent_id(options[:parent_id]) unless options[:parent_id].nil?
          Message.create(options)
        end
      end
    else
      raise "Required recipients"
    end
  rescue Exception => e
    raise e
  end

  def inbox(options = {})
    options[:deleted] = false
    options[:copies] = false
    self.messages.where(options)
  end

  def outbox(options = {})
    options[:deleted] = false
    options[:copies] = true
    self.messages.where(options)
  end

  def trash(options = {})
    options[:deleted] = true
    self.messages.where(options)
  end

  def empty_messages(options = {})
    if options.empty? or options[:inbox] or options[:outbox]
      self.inbox.update_all(:deleted => true)
      self.outbox.update_all(:deleted => true)
    elsif options[:trash]
      self.trash.delete_all
    end
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

    def create_root_catalog
      catalog_description = "Root catalog for #{full_name} (#{self.class.to_s})"
      catalogs.create(name: full_name.downcase, description: catalog_description, creator_id: self.id, updater_id: self.id)
    end
end

