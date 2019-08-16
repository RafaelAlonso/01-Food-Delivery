class CustomerView

  def display(customers)
    customers.each do |customer|
      puts "#{customer.id}: #{customer.name} (#{customer.address})"
    end
  end

  def ask(property)
    puts "What is the #{property} of your customer?"
    gets.chomp
  end

end
