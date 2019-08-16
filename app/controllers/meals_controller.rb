require_relative '../views/meal_view'

class MealsController

  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def list
    meals = @meal_repository.all
    @view.display(meals)
  end

  def add
    name = @view.ask('name')
    price = @view.ask('price')

    new_meal = Meal.new(name: name, price: price)
    @meal_repository.add(new_meal)

  end

end
