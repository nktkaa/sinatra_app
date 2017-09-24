require 'rubygems'
require 'sinatra'
require 'sinatra/json'
require 'sequel'

DB = Sequel.connect('postgres://crecker:crecker@localhost:5432/app')
=begin
DB.create_table :users do
	primary_key :id
	String :name
	String :lastname
	String :email

end
=end
#uncomment for the first use
class User < Sequel::Model
 plugin :validation_helpers
  def validate
    super
    validates_presence [:name, :lastname, :email]
    validates_unique :email
  end
end

get '/' do
	erb :index
end

get '/getusers' do
	users = User.all
	users.map! do |u|
		{:id=>u.id,:name=>u.name,:lastname=>u.lastname,:email=>u.email}
	end
	users.to_json
end

post '/' do
	name = params[:name].downcase.capitalize
	lastname = params[:lastname].downcase.capitalize
	email = params[:email]
	User.create(:name => name, :lastname => lastname, :email => email) #with insert validations don`t work
	redirect back
end

delete '/:id' do
	User.where(:id => params[:id]).delete
	redirect back
end

