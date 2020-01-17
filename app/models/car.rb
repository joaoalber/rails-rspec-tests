class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  
  validates :license_plate, presence: { message: 'Placa não pode ficar em branco' }
  validates :license_plate, uniqueness: { message: 'Placa já existente' }
  validates :color, presence: { message: 'Cor não pode ficar em branco' }
  validates :car_model_id, presence: { message: 'Modelo não pode ficar em branco' }
  validates :mileage, presence: { message: 'Quilometragem não pode ficar em branco' }
  validates :subsidiary_id, presence: { message: 'Filial não pode ficar em branco' }
  validates :status, presence: { message: 'Status não pode ficar em branco' }
  validates :mileage, numericality: { greater_than: 0, message: 'Quilometragem deve ser superior a 0' }
  

  def identification
    "#{car_model.name} - #{license_plate} - #{color}"
  end
end
