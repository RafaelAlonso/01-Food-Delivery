require 'csv'
require_relative '../models/employee'

class EmployeeRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_from_csv if File.exist?(@csv_file_path)

    # Modo ternário
    @next_id = @employees.empty? ? 1 : @employees.last.id + 1

  end

  def all
    @employees
  end

  def all_delivery_guys
    @employees.select do |employee|
      employee.delivery_guy?
    end

    # @employees.select(&:delivery_guy?)
  end

  def find(id_to_find)
    @employees.find { |employee| employee.id == id_to_find }
  end

  def find_by_username(username_to_find)
    @employees.find { |employee| employee.username == username_to_find }
  end

  private

  def load_from_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |row|
      @employees << Employee.new(row)
    end

  end


end
