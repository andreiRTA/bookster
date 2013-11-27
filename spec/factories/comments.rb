# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    collection_id 1
    comment "MyText"
  end
end
