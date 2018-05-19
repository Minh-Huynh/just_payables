require 'faker'

FactoryBot.define do
  factory :vendor do
    sequence(:name) {Faker::Company.name}
  end

  factory :contact do
    vendor
    sequence(:first_name) {Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
  end

  factory :show do
    sequence(:name) {Faker::SiliconValley.company}
    sequence(:location) {Faker::Address.city}
  end

  factory :order do
    vendor
    contact
    show
    term { Order.terms.values.sample }
    sequence(:invoice_number) {Faker::Commerce.promotion_code}
    sequence(:due_on) {Faker::Date.between(2.days.ago, 1.year.from_now)} 
    sequence(:order_amount) {Faker::Commerce.price}
    sequence(:description) {Faker::Company.catch_phrase}
  end
end
