FactoryGirl.define do
  factory :alert, :class => Refinery::Alerts::Alert do
    sequence(:title) { |n| "RefineryAlert-#{n}" }
    live_at { Time.zone.now }
  end
end
