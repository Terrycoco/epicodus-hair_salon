class Client
  attr_reader(:firstname, :lastname, :id)

  define_method(:initialize) do |attributes|
    @firstname = attributes.fetch(:firstname)
    @lastname = attributes.fetch(:lastname)
    @id = attributes.fetch(:id)
    @fullname = @firstname + ' ' + @lastname
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (firstname, lastname)
      VALUES ('#{@firstname}', '#{@lastname}') RETURNING client_id;")
      @id = result.first().fetch("client_id").to_i();
  end

  define_singleton_method(:all) do
    clients = []
    result = DB.exec("SELECT * from clients ORDER BY lastname, firstname;")
    result.each() do |row|
      firstname = row.fetch("firstname")
      lastname = row.fetch("lastname")
      id = row.fetch("client_id")
      client = Client.new({:firstname => firstname, :lastname => lastname, :id => id})
      clients.push(client)
    end
    return clients
  end

  define_method(:==) do |other_client|
    self.id().==other_client.id
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * from clients where client_id = #{id};")
    if result.cmd_tuples().>(0)
      firstname = result.first().fetch("firstname")
      lastname = result.first().fetch("lastname")
      id = result.first().fetch("client_id").to_i()
      client = Client.new({:firstname => firstname, :lastname => lastname, :id => id})
      return client
    else
      return nil
    end
  end

  define_method(:update) do |attributes|
    @firstname = attributes.fetch(:firstname, @firstname)
    @lastname = attributes.fetch(:lastname, @lastname)
    DB.exec("UPDATE clients SET firstname = '#{@firstname}', lastname = '#{@lastname}'
       WHERE client_id = #{@id}")
  end


  define_method(:delete) do
    DB.exec("DELETE from clients WHERE client_id = #{@id};")
  end

  define_method(:stylist) do
    stylist = nil
    result = DB.exec("SELECT * from stylists INNER JOIN clients on stylists.stylist_id = clients.stylist_id
       WHERE clients.client_id = #{@id};")
     if result.cmd_tuples().==(1)
       sid = result.first().fetch("stylist_id").to_i()
       firstname = result.first().fetch("firstname")
       lastname = result.first().fetch("lastname")
       stylist = Stylist.new({:firstname => firstname, :lastname => lastname, :id => sid})
     end
     return stylist
  end

  define_method(:set_stylist) do |stylist|
    sid = stylist.id
    DB.exec("UPDATE clients SET stylist_id = #{sid} WHERE client_id =#{@id}")
  end

end  #end class
