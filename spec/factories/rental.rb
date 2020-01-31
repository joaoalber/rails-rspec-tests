FactoryBot.define do
  factory :rental do
		code { "ZXC1234" }
		start_date { 1.day.from_now }
		end_date { 2.days.from_now }
		client
		car_category
		user
	end
end