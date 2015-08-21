require('rspec')
require('client')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
  end
end

describe(Client) do

  describe('#initialize') do
    it('creates a new client object') do
      client = Client.new({:firstname => 'Hairy', :lastname => 'Mess', :id => nil})
      expect(client.firstname).to(eq('Hairy'))
    end
  end

  describe('#save') do
    it('save client to db') do
      client = Client.new({:firstname => 'Harry', :lastname => 'Mess', :id => nil})
      client.save()
      expect(client.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('returns all clients from db') do
      client = Client.new({:firstname => 'Harry', :lastname => 'Mess', :id => nil})
      client.save()
      client2 = Client.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id => nil})
      client2.save()
      expect((Client.all).length()).to(eq(2))
    end
  end

  describe('.find') do
    it('finds a client by id') do
      client = Client.new({:firstname => 'Harry', :lastname => 'Mess', :id => nil})
      client.save()
      id = client.id()
      expect(Client.find(id)).to(eq(client))

    end
  end

  describe('#update') do
    it('updates a client') do
      client = Client.new({:firstname => 'Harry', :lastname => 'Mess', :id => nil})
      client.save()
      client.update({:firstname => 'Hairy'})
      expect(client.firstname()).to(eq('Hairy'))
    end
  end

  # describe('#delete') do
  #   it('deletes a client') do
  #     client = client.new({:firstname => 'Harry', :lastname => 'Mess', :id => nil})
  #     client.save()
  #     id = client.id
  #     client.delete()
  #     expect(client.find(id)).to(eq(nil))
  #   end
  # end

end
