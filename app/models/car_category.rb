class CarCategory < ApplicationRecord
  has_many :car_models
  has_many :cars, through: :car_models  
  has_many :rentals
  
  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :daily_rate, presence: { message: 'Diária não pode ficar em branco' }
  validates :car_insurance, presence: { message: 'Seguro não pode ficar em branco' }
  validates :third_party_insurance, presence: { message: 'Seguro contra terceiros
                                                não pode ficar em branco' }
  validates :daily_rate, numericality: { greater_than: 0, message: 'Diaria deve ser superior a 0'}
  validates :car_insurance, numericality: { greater_than: 0, message: 'Seguro deve ser superior a 0' }
  validates :third_party_insurance, numericality: { greater_than: 0, message: 'Seguro contra terceiros deve ser superior a 0' }

  

  def rental_price
    (car_insurance + daily_rate + third_party_insurance).to_i
  end

end
