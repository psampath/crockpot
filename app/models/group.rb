class Group < ActiveRecord::Base
  has_many :recipes, :through => :recipeGroups
  has_many :recipeGroups
end
