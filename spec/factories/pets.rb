FactoryBot.define do
  factory :pet do
    age { rand(1..15) }
    age_unit { %w[days months years].sample }
    gender { [ 0, 1, 2 ].sample }
    temperament { Faker::Lorem.sentence(word_count: 3) }
    vaccination_status { [ true, false ].sample }
    medical_history { Faker::Lorem.paragraph }
    recommended_food { Faker::Food.dish }
    common_health_issues { Faker::Lorem.sentence(word_count: 4) }
    status { [ 0, 1 ].sample }
    association :category
    association :breed

    after(:build) do |pet|
      pet.pet_images.attach(
        io: StringIO.new("fake image content"),
        filename: "test_image.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end
