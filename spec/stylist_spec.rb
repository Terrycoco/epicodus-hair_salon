require('rspec')
require('stylist')
require('pg')
require('pry')

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

  describe('.find') do
    it('finds a stylist by id') do
      stylist = Stylist.new({:firstname => 'Abigail', :lastname => 'Doe', :id => nil})
      stylist.save()
      id = stylist.id()
      expect(Stylist.find(id)).to(eq(stylist))
    end
  end

  describe('#update') do
    it('updates a stylist') do
      stylist = Stylist.new({:firstname => 'Abigail', :lastname => 'Doe', :id => nil})
      stylist.save()
      stylist.update({:firstname => 'Abbey'})
      expect(stylist.firstname()).to(eq('Abbey'))
    end
  end

  describe('#delete') do
    it('deletes a stylist') do
      stylist = Stylist.new({:firstname => 'Abigail', :lastname => 'Doe', :id => nil})
      stylist.save()
      id = stylist.id
      stylist.delete()
      expect(Stylist.find(id)).to(eq(nil))
    end
  end

end
