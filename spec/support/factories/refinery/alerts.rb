
FactoryGirl.define do
  factory :alert, :class => Refinery::Alerts::Alert do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

