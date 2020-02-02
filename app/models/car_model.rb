class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars, dependent: :destroy

  validates :name, presence: true
  validates :year, presence: true
  validates :motorization, presence: true
  validates :fuel_type, presence: true
end
