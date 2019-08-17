class OrderView
  def display(orders)
    orders.each do |order|
      puts "#{order.meal.name} #{order.customer.name} #{order.employee.username}"
    end
  end

  def display_my_orders(orders)
    orders.each do |order|
      puts "Id.#{order.id}: #{order.customer.name}: #{order.meal.name}"
    end
  end

  def ask(property)
    puts "What is the #{property} of your order?"
    return gets.chomp
  end
end
