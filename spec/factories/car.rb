FactoryBot.define do
  factory :car do
		license_plate { "DXC2132" }
		color { "Vermelho" }
		mileage { 50 }
		subsidiary
		car_model
  end
end