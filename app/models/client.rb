class Client < ApplicationRecord
  has_many :rentals, dependent: :destroy

	def identification
    "#{cpf} - #{name}"
  end
end
