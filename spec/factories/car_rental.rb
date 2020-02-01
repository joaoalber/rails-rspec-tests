FactoryBot.define do
  factory :car_rental do
    price { 30 }
    initial_mileage { 50 }
    final_mileage { 50 }
    car
    rental
  end
end
