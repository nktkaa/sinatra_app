require 'spec_helper'

include Rack::Test::Methods
 
def app
	Sinatra::Application
end

describe "GET routes" do
  
	it "should respond to /" do
		get '/'
		expect(last_response.status).to eq(200)
	end

	it "should respond to /getusers" do
		get '/getusers'
		expect(last_response.status).to eq(200)
	end
end

describe "POST user" do

	it "should be possible to create users" do
		Fabricate(:user).should be_valid
	end

	it "should have non empty forms" do
		FactoryGirl.build(:user, :name => "").should_not be_valid
	end

	it "should validate same emails" do
		Fabricate(:user, :email => "test@test.com")
		FactoryGirl.build(:user, :email => "test@test.com").should_not be_valid
	end
end

describe "DELETE /:id" do

	it "should delete user" do
		user = Fabricate(:user)
		id = user.id
		delete "/#{user.id}"
		User.where(:id => id).should be_empty
	end
end

=begin
describe "page working" do
	before do
      	fill_in('name', with: 'Test')
		fill_in('#lastname', with: 'Testing')
		fill_in('#email', with: 'test@testing.com')
		click_on('Submit')
    end

	it "should render user" do
		page.all('#list tr').each do |tr|
			next unless tr.has_selector?('test@testing.com')
			a = tr.text
		end
		a.should_not be_empty
	end

	it "should delete user" do

	end

end
=end