class RecipesController < ApplicationController
  before_filter :fetch_nav

  def index
    if params[:ing]
      ingredient = Ingredient.find(params[:ing])
      @recipes = ingredient.recipes.paginate(:page => params[:page], :per_page => 5)
    elsif params[:grp]
      group = Group.find(params[:grp])
      @recipes = group.recipes.paginate(:page => params[:page], :per_page => 5)
    else
      @recipes = Recipe.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def list
    @recipes = Recipe.all.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Your recipe was created succesfully"
      redirect_to recipes_list_path
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      redirect_to recipes_list_path
      # Handle a successful update.
    else
      render :edit
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def search
    @recipes = Recipe.where("search_terms LIKE :query or name LIKE :query",
          query: "%#{params[:search]}%" )
  end

  private
    def fetch_nav
      @groups = Group.select("id","name")
      @ingredients = Ingredient.all
    end

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :url, :description, :search_terms, recipeIngredient_attributes: [ingredient_attributes: [:id, :name]])
    end
end
