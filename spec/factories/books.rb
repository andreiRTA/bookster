# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "Harry Potter"
    author "Tom"
    description "Great book"
    image "MyString"
    isbn "1234"
  end
end
