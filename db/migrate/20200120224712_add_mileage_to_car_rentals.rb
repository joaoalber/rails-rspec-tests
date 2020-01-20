class AddMileageToCarRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :car_rentals, :initial_mileage, :integer
    add_column :car_rentals, :final_mileage, :integer
  end
end
