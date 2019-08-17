require_relative '../models/employee'
require_relative 'base_repository'

class EmployeeRepository < BaseRepository
  undef_method :add

  def initialize(csv_file_path)
    @model = Employee
    super
  end

  def all_delivery_guys
    @elements.select do |employee|
      employee.delivery_guy?
    end

    # @employees.select(&:delivery_guy?)
  end

  def find_by_username(username_to_find)
    @elements.find { |employee| employee.username == username_to_find }
  end

end
