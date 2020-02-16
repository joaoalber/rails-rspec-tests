class Accessory < ApplicationRecord
  has_one_attached :image
  belongs_to :rental, optional: true
end
