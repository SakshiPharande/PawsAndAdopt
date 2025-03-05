FactoryBot.define do
  factory :breed do
    breed_name { Faker::Creature::Dog.breed } # Generates a random dog breed
    association :category # Links breed to category
  end
end
