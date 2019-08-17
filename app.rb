require_relative 'router'

require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/employee_repository'
require_relative 'app/repositories/order_repository'

require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/employees_controller'
require_relative 'app/controllers/orders_controller'

meal_repo = MealRepository.new('data/meals.csv')
meal_cont = MealsController.new(meal_repo)

customer_repo = CustomerRepository.new('data/customers.csv')
customer_cont = CustomersController.new(customer_repo)

employee_repo = EmployeeRepository.new('data/employees.csv')
employee_cont = EmployeesController.new(employee_repo)

order_repo = OrderRepository.new('data/orders.csv', meal_repo, employee_repo, customer_repo)
order_cont = OrdersController.new(meal_repo, employee_repo, customer_repo, order_repo)

router = Router.new(meal_cont, customer_cont, employee_cont, order_cont)

router.run
