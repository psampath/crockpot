class RecipeGroup < ActiveRecord::Base
  #self.table_name = "recipe_ingredients"
  belongs_to :group
  belongs_to :recipe
end
