class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :listing
      t.date :check_in
      t.date :check_out
      t.integer :num_of_guests
      t.timestamps
    end
  end
end
