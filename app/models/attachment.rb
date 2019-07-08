class Attachment < ApplicationRecord
  belongs_to :micropost
  mount_uploader :photos, PhotoUploader
  validate :photo_size
  private

  def photo_size
    if photos.size > 5.megabytes
      errors.add :photos, "should be less than 5MB"
    end
  end
end
