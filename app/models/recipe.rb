class Recipe < ActiveRecord::Base
  has_many :ingredients, :through => :recipeIngredients
  has_many :groups, :through => :recipeGroups
  has_many :recipeIngredients
  has_many :recipeGroups

  accepts_nested_attributes_for :recipeIngredients,
           :reject_if => :all_blank,
           :allow_destroy => true
  accepts_nested_attributes_for :ingredients
end
