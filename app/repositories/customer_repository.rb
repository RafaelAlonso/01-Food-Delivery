require 'csv'
require_relative '../models/customer'

class CustomerRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    load_from_csv if File.exist?(@csv_file_path)

    # Modo ternário
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1

  end

  def all
    @customers
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_to_csv
  end

  def find(id_to_find)
    @customers.find { |customer| customer.id == id_to_find }
  end

  private

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_from_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |row|
      @customers << Customer.new(row)
    end

  end

end
