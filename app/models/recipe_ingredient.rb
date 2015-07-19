class RecipeIngredient < ActiveRecord::Base
  #self.table_name = "recipe_ingredients"
  belongs_to :ingredient
  belongs_to :recipe

  accepts_nested_attributes_for :ingredient,
                                :reject_if => :all_blank
end
