require_relative '../views/employee_view'

class EmployeesController

  def initialize(employee_repo)
    @employee_repo = employee_repo
    @view = EmployeeView.new
  end

  def list
    employees = @employee_repo.all_delivery_guys
    @view.display(employees)
  end

  def find_user(username_to_find)
    @employee_repo.find_by_username(username_to_find)
  end

end
