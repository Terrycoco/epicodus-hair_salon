class Stylist
  attr_reader(:firstname, :lastname, :id)

  define_method(:initialize) do |attributes|
    @firstname = attributes.fetch(:firstname)
    @lastname = attributes.fetch(:lastname)
    @id = attributes.fetch(:id)
    @fullname = @firstname + ' ' + @lastname
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (firstname, lastname)
      VALUES ('#{@firstname}', '#{@lastname}') RETURNING stylist_id;")
      @id = result.first().fetch("stylist_id").to_i();
  end

  define_singleton_method(:all) do
    stylists = []
    result = DB.exec("SELECT * from stylists;")
    result.each() do |row|
      firstname = row.fetch("firstname")
      lastname = row.fetch("lastname")
      id = row.fetch("stylist_id")
      stylist = Stylist.new({:firstname => firstname, :lastname => lastname, :id => id})
      stylists.push(stylist)
    end
    return stylists
  end

  define_method(:==) do |other_stylist|
    self.id().==other_stylist.id
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * from stylists where stylist_id = #{id};")
    if result.cmd_tuples().>(0)
      firstname = result.first().fetch("firstname")
      lastname = result.first().fetch("lastname")
      id = result.first().fetch("stylist_id").to_i()
      stylist = Stylist.new({:firstname => firstname, :lastname => lastname, :id => id})
      return stylist
    else
      return nil
    end
  end

  define_method(:update) do |attributes|
    @firstname = attributes.fetch(:firstname, @firstname)
    @lastname = attributes.fetch(:lastname, @lastname)
    DB.exec("UPDATE stylists SET firstname = '#{@firstname}', lastname = '#{@lastname}'
       WHERE stylist_id = #{@id}")
  end


  define_method(:delete) do
    DB.exec("DELETE from stylists WHERE stylist_id = #{@id};")
  end

  define_method(:clients) do
    results = DB.exec("SELECT * from clients where stylist_id = #{@id}")
    clients = []
    results.each() do |row|
      firstname = row.fetch("firstname")
      lastname = row.fetch("lastname")
      id = row.fetch("client_id").to_i()
      client = Client.new({:firstname => firstname, :lastname => lastname, :id => id})
      clients.push(client)
    end
    clients
  end

  define_method(:add_client) do |client|
    cid = client.id
    DB.exec("UPDATE clients SET stylist_id = #{@id} WHERE client_id =#{cid};")
  end



end #end class
