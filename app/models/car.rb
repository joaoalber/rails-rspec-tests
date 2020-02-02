class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_one :car_rental, dependent: :destroy
  has_one :rental, through: :car_rentals

  enum status: { available: 0, unavailable: 5 }

  validates :license_plate, presence: true, uniqueness: true
  validates :color, presence: true
  validates :mileage, presence: true, numericality: { greater_than: 0 }

  def identification
    return 'Carro não cadastrado corretamente' if car_model.nil?

    "#{car_model.name} - #{license_plate} - #{color}"
  end
end
