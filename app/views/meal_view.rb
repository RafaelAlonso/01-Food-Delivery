class MealView

  def display(meals)
    meals.each do |meal|
      puts "#{meal.id}: #{meal.name} ($#{meal.price})"
    end
  end

  def ask(property)
    puts "What is the #{property} of your meal?"
    gets.chomp
  end

end
