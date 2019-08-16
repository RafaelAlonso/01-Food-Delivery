require_relative 'router'

require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/employee_repository'

require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/employees_controller'

meal_repo = MealRepository.new('data/meals.csv')
meal_cont = MealsController.new(meal_repo)

customer_repo = CustomerRepository.new('data/customers.csv')
customer_cont = CustomersController.new(customer_repo)

employee_repo = EmployeeRepository.new('data/employees.csv')
employee_cont = EmployeesController.new(employee_repo)

router = Router.new(meal_cont, customer_cont, employee_cont)

router.run
