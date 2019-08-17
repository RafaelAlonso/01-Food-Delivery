class EmployeeView
  def display(employees)
    employees.each do |employee|
      puts "#{employee.id} - #{employee.username}"
    end
  end
end
