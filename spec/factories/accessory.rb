FactoryBot.define do
  factory :accessory do
    name { 'GPS' }
    daily_rate { 50 }
    description { 'GPS para localização do carro' }

    trait :with_image do
      image { fixture_file_upload(Rails.root + 'spec/fixtures/files/photo.png') }
    end
  end
end
