class Subsidiary < ApplicationRecord
  has_many :cars, dependent: :destroy

  validates :name, :cnpj, :address, uniqueness: { message: 'Filial já existente' }
  validates_cnpj_format_of :cnpj, message: 'CNPJ Inválido'
end
