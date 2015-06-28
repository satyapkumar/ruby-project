class Timeline < ActiveRecord::Base
  belongs_to :member
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :member_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  
  private
  # Validates the size of an upload picture
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
