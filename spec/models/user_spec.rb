require 'spec_helper'

describe User do
 
	 describe "creating a user" do
  	it "should create an auth_token" do
  		user = FactoryGirl.create(:user)
  		expect(user.auth_token).to_not be_nil
  	end
	end

end
