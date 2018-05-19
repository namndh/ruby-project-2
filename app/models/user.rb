class User < ApplicationRecord
  has_many :songs
  has_many :comments
  has_many :likes
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_integrity_of :avatar
  validates_processing_of :avatar

  private
  def avatar_size_validation
    errors[:avatar] << "Should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
