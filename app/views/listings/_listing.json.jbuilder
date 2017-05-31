json.extract! listing, :id, :user_id, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price_per_night, :description, :created_at, :updated_at
json.url listing_url(listing, format: :json)
