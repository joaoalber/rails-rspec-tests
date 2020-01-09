class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category

  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :year, presence: { message: 'Ano não pode ficar em branco' }
  validates :manufacturer_id, presence: { message: 'Fabricante não pode ficar em branco' }
  validates :motorization, presence: { message: 'Motorização contra terceiros
                                      não pode ficar em branco' }
  validates :car_category_id, presence: { message: 'Categoria não pode ficar em branco' }
  validates :fuel_type, presence: { message: 'Fabricante não pode ficar em branco' }

end
