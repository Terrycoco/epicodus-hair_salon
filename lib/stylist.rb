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

end #end class
