FactoryBot.define do
  factory :car_category do
    name { 'C' }
    daily_rate { 50 }
    car_insurance { 70 }
    third_party_insurance { 20 }
  end
end
