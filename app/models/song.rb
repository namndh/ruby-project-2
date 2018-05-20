class Song < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :file, SongUploader

  validates :user_id, presence: true
  validates :file, presence: true
  validates :title, presence: true

  scope :hot_songs, -> {joins(:likes).group('songs.id').order('count(likes.id) desc').limit(10)}

  def self.search(search)
    # titleStr = title ? title : ''
    # artistStr = artist ? artist : ''
    where(["title like ? or artist like ?", "%#{search}%", "%#{search}%"])
    # else
    #   where(["title like ?", ''])
    # end
  end
end
