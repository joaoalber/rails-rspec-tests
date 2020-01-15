class Client < ApplicationRecord

	def identification
    "#{cpf} - #{name}"
  end
end
