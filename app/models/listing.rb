class Listing < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  # mount_uploaders :images, ImageUploader
end
