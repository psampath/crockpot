class Ingredient < ActiveRecord::Base
  has_many :recipes, :through => :recipeIngredients
  has_many :recipeIngredients
end
