require 'csv'
require_relative '../models/meal'

class MealRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    load_from_csv if File.exist?(@csv_file_path)

    # Modo ternário
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1

    # Modo 'completo'
    # if @meals.empty?
    #   @next_id = 1
    # else
    #   @next_id = @meals.last.id + 1
    # end

  end

  def all
    @meals
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_to_csv
  end

  def find(id_to_find)
    @meals.find { |meal| meal.id == id_to_find }
  end

  private

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_from_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |row|
      @meals << Meal.new(row)
    end

  end

end
