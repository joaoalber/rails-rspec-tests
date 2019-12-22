class CarCategory < ApplicationRecord
    validates :name, presence: { message: 'Nome não pode ficar em branco' }
    validates :daily_rate, presence: { message: 'Diária não pode ficar em branco' }
    validates :car_insurance, presence: { message: 'Seguro não pode ficar em branco' }
    validates :third_party_insurance, presence: { message: 'Seguro contra terceiros
    não pode ficar em branco' }
end
