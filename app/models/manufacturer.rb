class Manufacturer < ApplicationRecord
    has_many :car_models, dependent: :destroy

    validates :name, presence: { message: 'Nome não pode ficar em branco' },
    uniqueness: { message: 'Nome já existente' }
end
