require('rspec')
require('stylist')
require('pg')

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stylists *;")
  end
end

describe(Stylist) do

  describe('#initialize') do
    it('creates a new stylist object') do
      stylist = Stylist.new({:firstname => 'Abigail', :lastname => 'Doe', :id => nil})
      expect(stylist.firstname).to(eq('Abigail'))
    end
  end





end
