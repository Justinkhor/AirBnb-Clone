class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :place_type
      t.string :property_type
      t.integer :room_number
      t.integer :bed_number
      t.integer :guest_number
      t.string :country
      t.string :state
      t.string :city
      t.integer :zipcode
      t.string :address
      t.integer :price_per_night
      t.string :description

      t.timestamps
    end
  end
end
