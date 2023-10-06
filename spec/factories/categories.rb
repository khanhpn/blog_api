FactoryBot.define do
  factory :category do
    association :user, factory: :user
    name { 'Test Category' }
    isShow { true }
  end
end
