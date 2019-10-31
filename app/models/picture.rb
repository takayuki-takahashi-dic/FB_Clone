class Picture < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :content, presence: true
  validates :content, length: { in: 1..140 }
  validates :image, presence: true
end
