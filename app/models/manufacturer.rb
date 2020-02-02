class Manufacturer < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
