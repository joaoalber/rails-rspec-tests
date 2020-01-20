class Client < ApplicationRecord
  has_many :rentals

	def identification
    "#{cpf} - #{name}"
  end
end
