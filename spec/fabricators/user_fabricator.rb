require 'faker'

Fabricator(:user) do
	name { Faker::Name.first_name }
	lastname { Faker::Name.last_name }
	email { Faker::Internet.email }
end