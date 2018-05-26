require 'faker'

FactoryBot.define do
  factory :order do
    vendor {Faker::Company.name}
    contact {Faker::Name.first_name}
    show {Faker::SiliconValley.company}
    term { [30,45,60,120,180].sample }
    shipping_percentage {[0,1,2,3,4].sample}
    sequence(:invoice_number) {Faker::Commerce.promotion_code}
    sequence(:ship_on) {Faker::Date.between(1.month.from_now, 1.year.from_now)} 
    sequence(:ordered_on) {Faker::Date.between(1.month.from_now, 1.year.from_now)} 
    sequence(:order_amount) {Faker::Commerce.price}
    sequence(:description) {Faker::Company.catch_phrase}
  end
end
