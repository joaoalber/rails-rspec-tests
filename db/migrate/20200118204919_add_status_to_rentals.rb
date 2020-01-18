class AddStatusToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :status, :integer, default: 0
  end
end
