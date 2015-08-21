require('spec_helper')

describe(Stylist) do

  describe('#clients') do
    it('should be empty at first') do
      stylist = Stylist.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id=> nil})
      stylist.save()
      expect(stylist.clients()).to(eq([]))
    end

  end


  describe('#add_client') do
      it('adds a client to a stylist') do
        client = Client.new({:firstname => 'Hairy', :lastname => 'Mess', :id=> nil})
        client.save()
        stylist = Stylist.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id=> nil})
        stylist.save()
        stylist.add_client(client)
        expect(stylist.clients().include?(client)).to(eq(true))
      end
    end

    describe('#drop_client') do
      it('removes a client from a stylist') do
        client = Client.new({:firstname => 'Hairy', :lastname => 'Mess', :id=> nil})
        client.save()
        stylist = Stylist.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id=> nil})
        stylist.save()
        stylist.add_client(client)
        stylist.drop_client(client)
        expect(stylist.clients().include?(client)).to(eq(false))
      end
    end

end

describe(Client) do

  describe('#stylist') do
    it('should be nil at first') do
        client = Client.new({:firstname => 'Hairy', :lastname => 'Mess', :id=> nil})
        client.save()
        stylist = Stylist.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id=> nil})
        stylist.save()
        expect(client.stylist()).to(eq(nil))
    end
  end

  describe('#set_stylist') do
    it('updates the stylist for client') do
      client = Client.new({:firstname => 'Hairy', :lastname => 'Mess', :id=> nil})
      client.save()
      stylist = Stylist.new({:firstname => 'Edward', :lastname => 'Scissorhands', :id=> nil})
      stylist.save()
      client.set_stylist(stylist)
      expect(client.stylist()).to(eq(stylist))
    end
  end


end
