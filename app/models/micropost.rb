class Micropost < ApplicationRecord
  belongs_to :user
  has_many :attachments, dependent: :destroy
  scope :sort_by_time, -> { order created_at: :desc }

  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  accepts_nested_attributes_for :attachments
  # validate :picture_size
  # validate :picture_presence

  # private

  # def picture_size
  #   if picture.size > 5.megabytes
  #     errors.add :picture, "should be less than 5MB"
  #   end
  # end

  # def picture_presence
  #   if picture.blank? && content.blank?
  #     errors.add :picture, "should have presence picture or content"
  #   end
  # end
end
