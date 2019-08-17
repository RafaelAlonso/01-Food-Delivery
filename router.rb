# TODO: implement the router of your app.
class Router

  def initialize(meal_cont, cust_cont, empl_cont, orde_cont)
    @meal_controller = meal_cont
    @cust_controller = cust_cont
    @empl_controller = empl_cont
    @orde_controller = orde_cont

    @times_tried = 0
    @user = nil
  end

  def run
    system 'clear'
    puts "================================="
    puts "Welcome to the Food Delivery App!"
    puts "================================="

    login
  end

  def main_loop
    loop do
      list_opt
      option = gets.chomp.to_i

      if @user.manager?
        execute_manager(option)
      else
        execute_delivery(option)
      end
    end
  end

  def list_opt
    puts "\n================================="
    puts 'What do you want to do next?'

    if @user.manager?
      puts '1 - List All the meals'
      puts '2 - Add a new meal'
      puts '3 - List All customers'
      puts '4 - Add a new customer'
      puts '5 - List All undelivered orders'
      puts '6 - Add an order'
    else
      puts '1 - List my undelivered orders'
      puts '2 - Mark an order as delivered'
    end

    puts '0 - Exit the program'
    puts "================================="
  end

  def execute_manager(opt)
    system 'clear'
    case opt
    when 1
      @meal_controller.list
    when 2
      @meal_controller.add
    when 3
      @cust_controller.list
    when 4
      @cust_controller.add
    when 5
      @orde_controller.list_undelivered_orders
    when 6
      @meal_controller.list
      puts "============================="
      @empl_controller.list
      puts "============================="
      @cust_controller.list
      puts "============================="

      @orde_controller.add
    when 0
      puts 'Bye bye!'
      exit
    else
      puts 'Invalid input!'
    end
  end

  def execute_delivery(opt)
    system 'clear'
    case opt
    when 1
      @orde_controller.list_my_orders(@user)
    when 2
      @orde_controller.mark_as_delivered(@user)
    when 0
      puts 'Bye bye!'
      exit
    else
      puts 'Invalid input!'
    end
  end

  private

  def login
    puts '> What is your username?'
    username = gets.chomp
    puts '> What is your password?'
    password = gets.chomp

    @user = @empl_controller.find_user(username)

    if !@user.nil? && @user.password == password
      main_loop
    else
      @times_tried += 1
      if @times_tried == 3
        system 'clear'
        puts 'Mas tu é burro hein!'
        exit
      else
        puts 'Invalid Credentials'
        login
      end
    end

  end

end
