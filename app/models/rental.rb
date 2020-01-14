class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
end
