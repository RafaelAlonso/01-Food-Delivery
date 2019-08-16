class EmployeesController

  def initialize(employee_repo)
    @employee_repo = employee_repo
  end

  def find_user(username_to_find)
    @employee_repo.find_by_username(username_to_find)
  end

end
