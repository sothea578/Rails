class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  scope :active, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    errors.add :picture, t("limit") if picture.size > Setting.limit.megabytes
  end
end
