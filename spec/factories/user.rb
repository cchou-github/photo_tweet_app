FactoryBot.define do
  factory :user do
    sequence(:account)  { |n| "testuser_#{n}" }
    password { "12345678" }
  end
end