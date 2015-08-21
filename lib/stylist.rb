class Stylist
  attr_reader(:firstname, :lastname, :id)

  define_method(:initialize) do |attributes|
    @firstname = attributes.fetch(:firstname)
    @lastname = attributes.fetch(:lastname)
    @id = attributes.fetch(:id)
    @fullname = @firstname + ' ' + @lastname
  end



end #end class
