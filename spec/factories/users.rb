# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Dario"
		last_name "D"
		username "bigd"
		email "dario@gmail.com"
		password "foobar"
		password_confirmation "foobar"
  end
end
