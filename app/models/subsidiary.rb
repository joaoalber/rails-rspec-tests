class Subsidiary < ApplicationRecord
  has_many :cars, dependent: :destroy

  validates :name, :cnpj, :address, uniqueness: true
  validates_cnpj_format_of :cnpj, message: 'CNPJ Inválido'
end
