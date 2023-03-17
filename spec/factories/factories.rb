FactoryBot.define do
  factory :user do
    name { 'test' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
