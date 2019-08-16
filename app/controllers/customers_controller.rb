require_relative '../views/customer_view'

class CustomersController

  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def list
    customers = @customer_repository.all
    @view.display(customers)
  end

  def add
    name = @view.ask('name')
    address = @view.ask('address')

    new_customer = Customer.new(name: name, address: address)
    @customer_repository.add(new_customer)

  end

end
