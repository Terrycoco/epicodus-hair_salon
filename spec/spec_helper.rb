require('rspec')
require('stylist')
require('client')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE from clients *;")
    DB.exec("DELETE FROM stylists *;")
  end
end
