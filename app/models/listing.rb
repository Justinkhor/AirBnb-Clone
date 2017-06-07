class Listing < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :reservations, dependent: :destroy
  # mount_uploaders :images, ImageUploader
  searchkick match: :word_start, searchable: [:country, :state, :city, :zipcode, :address, :description]
end
