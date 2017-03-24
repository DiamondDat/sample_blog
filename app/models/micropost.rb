class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes   ,                    dependent: :destroy
  has_many :comments, as: :commentable,  dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  # def self.liked_by?(user)
  #   user_liked_id = "SELECT user_id FROM likes
  #                    INNER JOIN microposts ON likes.micropost_id = micropost.id
  #                    INNER JOIN users ON micropost.user_id = user.id"

  #   if user == User.where("id IN (:user_liked_id)")
  #     return true
  #   else
  #     return false
  #   end
  # end

  private

    # validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
