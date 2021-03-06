class Micropost < ApplicationRecord
  belongs_to :user

  scope :sort_by_time, ->{order created_at: :desc}
  scope :new_feed_items, (lambda do |id|
    where(user_id: Relationship.following_ids(id))
    .or(Micropost.where(user_id: id))
  end)

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, length: {maximum: Settings.micropost.content.max_length}
  validate :picture_presence
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.micropost.picture_capacity.megabytes
    errors.add :picture, I18n.t("error_picture",
      size: Settings.micropost.picture_capacity)
  end

  def picture_presence
    return unless picture.blank? && content.blank?
    errors.add :picture, I18n.t("error_exist")
  end
end
