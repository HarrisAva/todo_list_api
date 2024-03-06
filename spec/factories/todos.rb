FactoryBot.define do
  factory :todo do
    body { Faker::Lorem.sentence }
    is_completed { false }
  end
end
