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

  describe('#save') do
    it('save stylist to db') do
      stylist = Stylist.new({:firstname => 'Abigail', :lastname => 'Doe', :id => nil})
      stylist.save()
      expect(stylist.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('returns all stylists from db') do
      stylist = Stylist.new({:firstname => 'Abigail', :lastname => 'Doe', :id => nil})
      stylist.save()
      stylist2 = Stylist.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id => nil})
      stylist2.save()
      expect((Stylist.all).length()).to(eq(2))
    end
  end


end
