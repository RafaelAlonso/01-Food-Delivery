require 'csv'
require_relative '../models/order'

class OrderRepository

  def initialize(csv_file_path, meal_repo, employee_repo, customer_repo)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repo
    @employee_repository = employee_repo
    @customer_repository = customer_repo
    @orders = []

    load_from_csv if File.exist? @csv_file_path
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def undelivered_orders
    @orders.select { |order| order.delivered? == false }
    # @orders.select { |order| !order.delivered? }
    # @orders.reject { |order| order.delivered? }
    # @orders.reject(&:delivered?)
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_to_csv
  end

  def mark_as_delivered(order)
    order.deliver!
    save_to_csv
  end

  private

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'employee_id', 'customer_id']
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def load_from_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |row|
      properties = {
        id: row[:id],
        meal: @meal_repository.find(row[:meal_id].to_i),
        customer: @customer_repository.find(row[:customer_id].to_i),
        employee: @employee_repository.find(row[:employee_id].to_i),
        delivered: row[:delivered] == 'true'
      }

      @orders << Order.new(properties)
    end
  end


end
