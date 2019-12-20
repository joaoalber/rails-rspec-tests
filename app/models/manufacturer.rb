class Manufacturer < ApplicationRecord
    validates :name, presence: { message: 'Nome não pode ficar em branco' }
end
