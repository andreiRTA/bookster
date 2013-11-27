require 'spec_helper'

feature "signing up a user" do
	
	scenario "with valid information" do
		visit root_path
		click_link "Sign Up Now!"
		fill_in "First Name", with: "Dario"
		fill_in "Last Name", with: "D"
		fill_in "Username", with: "Big D"
		fill_in "Email", with: "dario@gmail.com"
		fill_in "Password", with: "password"
		fill_in "Confirmation", with: "password"
		click_button "Sign Up"
		expect(page).to have_content("Big D")
	end

	scenario "with invalid information" do
		visit root_path
		click_link "Sign Up Now!"
		fill_in "First Name", with: "Dario"
		fill_in "Last Name", with: "D"
		fill_in "Username", with: ""
		fill_in "Email", with: "dario@gmail"
		fill_in "Password", with: "password"
		fill_in "Confirmation", with: "password"
		click_button "Sign Up"
		expect(page).to have_content("Username can't be blank")
		expect(page).to have_content("Email is invalid")
		expect(page).to have_content("Username is too short")
	end

end

feature "logging in a user" do

	let(:user) { FactoryGirl.create(:user) }

	scenario "with valid information" do
		visit root_path
		click_link "here"
		fill_in "Username", with: user.username
		fill_in "Password", with: user.password
		click_button "Log In"
		expect(page).to have_content("Welcome back, #{user.first_name}!")
		expect(page).to have_link("Log Out")
	end

	scenario "with invalid information" do
		visit root_path
		click_link "here"
		fill_in "Username", with: "Timmy"
		fill_in "Password", with: "Thomson"
		click_button "Log In"
		expect(page).to have_content("Your username and/or password is incorrect")
		expect(page).to have_link("Log In")
	end
end

feature "users book collection" do

	let(:user) { FactoryGirl.create(:user) }

	before do
		signin(user)
		visit search_for_book_path
		fill_in :search, with: "Harry Potter"
		click_button "Search"
	end

	scenario "searching for a book and adding it to collection" do
		expect(page).to have_content("Search results for 'Harry Potter'")
		first(:button, "Add To Collection").click
		expect(Book.count).to eq(1)
		expect(user.collection.books.count).to eq(1)
		expect(page).to have_content(user.username)
	end

	scenario "adding a book that is already in collection" do
		first(:button, "Add To Collection").click
		visit search_for_book_path
		fill_in :search, with: "Harry Potter"
		click_button "Search"
		first(:button, "Add To Collection").click
		expect(user.collection.books.count).to eq(1)
		expect(page).to have_content("That book is already in your collection.")
	end

	scenario "adding a comment about collection" do
		first(:button, "Add To Collection").click
		fill_in "comment_comment", with: "This is a great collection man!"
		click_button "Submit Your Comment"
		expect(user.collection.comments.count).to eq(1)
		expect(page).to have_content("This is a great collection man!")
	end
end