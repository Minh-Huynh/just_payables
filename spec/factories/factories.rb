require 'faker'

FactoryBot.define do
  factory :vendor do
    name Faker::Company.name
  end

  factory :contact do
    vendor
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end

  factory :show do
    name Faker::SiliconValley.company
    location Faker::Address.city
  end

  factory :order do
    vendor
    contact
    show
    order_amount Faker::Commerce.price
    description Faker::Company.catch_phrase
  end
end
