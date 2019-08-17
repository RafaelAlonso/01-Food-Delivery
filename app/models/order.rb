class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

end
