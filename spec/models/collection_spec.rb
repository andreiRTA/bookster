require 'spec_helper'

describe Collection do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  describe "add_to_collection method" do
  	it "should create new user collection if one doesn't already exist" do
  		expect(user.collection).to eq(nil)
  		Collection.add_to_collection(user, book)
  		expect(user.collection).to_not eq(nil)
  	end

  	it "should add a book to collection if it's not already in there" do
  		Collection.add_to_collection(user, book)
  		expect(user.collection.books.count).to eq(1)
  	end

  	it "should not add a book to collection if it's already in there" do
  		Collection.add_to_collection(user, book)
  		expect(user.collection.books.count).to eq(1)
  		Collection.add_to_collection(user, book)
  		expect(user.collection.books.count).to_not eq(2)
  	end
  end

  describe "already_in_collection? method" do
  	it "should return true if books exists in collection" do
  		Collection.add_to_collection(user, book)
  		exist = Collection.already_in_collection?(user, book)
  		expect(exist).to eq(true)
  	end

  	it "should return false if book is not in collection" do
  		book2 = FactoryGirl.create(:book, isbn: '9876') 
  		Collection.add_to_collection(user, book)
  		exist = Collection.already_in_collection?(user, book2)
  		expect(exist).to eq(false)
  	end
  end
end
