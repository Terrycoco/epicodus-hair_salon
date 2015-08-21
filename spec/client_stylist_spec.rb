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

end
