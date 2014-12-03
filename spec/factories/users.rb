FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "Fake name #{i}" }
    sequence(:email) { |i| "fake#{i}@example.com" }
  end
end
