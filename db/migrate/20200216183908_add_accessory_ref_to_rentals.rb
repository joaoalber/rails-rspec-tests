class AddAccessoryRefToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :accessory, foreign_key: true
  end
end
