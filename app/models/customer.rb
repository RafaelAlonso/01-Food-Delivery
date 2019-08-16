class Customer
  attr_reader :name, :address
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @address = attributes[:address]
  end

end
