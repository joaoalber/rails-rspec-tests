class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  def identification
    "#{car_model.name} - #{license_plate} - #{color}"
  end
end
