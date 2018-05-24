class User < ApplicationRecord
  has_many :songs
  has_many :comments
  has_many :likes
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  validates :username, presence: :true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def set_default_role
    self.role ||= :user
  end

  attr_writer :login

  def login
    @login || self.username || self.email
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  validates_integrity_of :avatar
  validates_processing_of :avatar

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  private
  def avatar_size_validation
    errors[:avatar] << "Should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
