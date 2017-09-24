require File.join(File.dirname(__FILE__), '../app.rb')
 
require 'rack/test'
require 'rspec'
require 'fabrication'
require 'factory_girl'
require 'capybara/dsl'
require 'database_cleaner'
require 'selenium/webdriver'

FactoryGirl.find_definitions

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end