class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @price = attributes[:price].to_i
  end

end
