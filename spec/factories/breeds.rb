FactoryBot.define do
  factory :breed do
    breed_name { "Golden Retriever" } # Generates a random dog breed
    association :category # Links breed to category
  end
end
