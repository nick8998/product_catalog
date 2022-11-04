FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "My title #{n}" }
    sequence(:description) { |n| "My description #{n}" }
    details { 'some' }
    hand { true }
    sequence(:image_url) { |n| "My image #{n}" }

    trait :invalid do
      description { nil }
    end
  end
end
