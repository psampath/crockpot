class CreateRecipeGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :recipe_groups do |t|
      t.belongs_to :recipe, index: true
      t.belongs_to :group, index: true
    end

  end
end
