FactoryGirl.define do
  factory :alert, :class => Refinery::Alerts::Alert do
    sequence(:title) { |n| "RefineryAlert-#{n}" }
    live_at { Time.zone.now }

    trait :live do
      live_at { Time.zone.now }
    end

    trait :expired do
      down_at { Time.zone.now }
    end
  end
end
