FactoryBot.define do
  factory :car_model do
		name { "Uno" }
		year { "2015" }
		fuel_type { "Gasolina" }
		motorization { "2.0" }
		manufacturer
		car_category
  end
end