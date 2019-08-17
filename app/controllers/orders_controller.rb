require_relative '../views/order_view'

class OrdersController
  def initialize(meal_repo, employee_repo, customer_repo, order_repo )
    @meal_repo = meal_repo
    @employee_repo = employee_repo
    @customer_repo = customer_repo
    @order_repo = order_repo
    @view = OrderView.new
  end

  def list_undelivered_orders
    undelivered_orders = @order_repo.undelivered_orders
    @view.display(undelivered_orders)
  end

  def add
    meal_id = @view.ask("meal id").to_i
    employee_id = @view.ask("employee id").to_i
    customer_id =  @view.ask("customer id").to_i

    properties = {
      meal: @meal_repo.find(meal_id),
      employee: @employee_repo.find(employee_id),
      customer: @customer_repo.find(customer_id)
    }

    order = Order.new(properties)
    @order_repo.add(order)
  end

  def list_my_orders(employee)
    my_orders = @order_repo.undelivered_orders.select { |order| order.employee == employee }
    @view.display_my_orders(my_orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_id = @view.ask('order id').to_i

    my_undelivered_orders = @order_repo.undelivered_orders.select { |order| order.employee == employee }
    order = my_undelivered_orders.find{ |order| order.id == order_id }

    @order_repo.mark_as_delivered(order) unless order.nil?
  end

end
