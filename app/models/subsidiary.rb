class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, uniqueness: { message: 'Filial já existente' }
    validates_cnpj_format_of :cnpj, message: 'CNPJ Inválido'
end
