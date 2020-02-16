class AddCancellationReasonToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :cancellation_reason, :text
  end
end
