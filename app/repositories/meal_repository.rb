require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository

  def initialize(csv_file_path)
    @model = Meal
    super
  end

  private

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'price']
      @elements.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

end
