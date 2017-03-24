class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  belongs_to :commentable, polymorphic: true
  has_many   :comments,    as: :commentable, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
