# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
(1..100).each do |i|
  @recipe = Recipe.create!(name:"testName #{i}", url: "testUrl #{i}", summary:"test-summary #{i}",
                  description:"test-description #{i}", search_terms:"test#{i}-search_terms")
  @recipe.ingredients << Ingredient.create!(name:"test-ingredients #{i}")
  @recipe.groups << Group.create!(name:"test-group #{i}")
end
