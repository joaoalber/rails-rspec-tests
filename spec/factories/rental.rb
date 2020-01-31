FactoryBot.define do
  factory :rental do
		code { "ZXC1234" }
		start_date { 1.day.from.now }
		end_date { 2.days.from.now }
		client
		car_category
		user
	end
end