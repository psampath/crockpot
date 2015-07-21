class Recipe < ActiveRecord::Base
  has_many :ingredients, :through => :recipeIngredients
  has_many :groups, :through => :recipeGroups
  has_many :recipeIngredients
  has_many :recipeGroups

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  accepts_nested_attributes_for :recipeIngredients,
           :reject_if => :all_blank,
           :allow_destroy => true
  accepts_nested_attributes_for :ingredients
end
