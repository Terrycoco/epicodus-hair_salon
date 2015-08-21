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

end #end class
