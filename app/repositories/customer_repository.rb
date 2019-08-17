require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository

  def initialize(csv_file_path)
    @model = Customer
    super
  end

  private

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'address']
      @elements.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end



end
