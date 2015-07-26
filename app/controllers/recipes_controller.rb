class RecipesController < ApplicationController
  before_action :fetch_nav
  before_action :authenticate, :only => [:new, :edit, :list]

  def index
    if params[:ing]
      ingredient = Ingredient.find(params[:ing])
      @recipes = ingredient.recipes.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    elsif params[:grp]
      group = Group.find(params[:grp])
      @recipes = group.recipes.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    else
      @recipes = Recipe.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def list
    @recipes = Recipe.all.order('updated_at DESC')
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
    if params[:search].empty?
        @recipes = Recipe.all.order('created_at DESC')
        return @recipes
    end
    terms = params[:search].split
    terms.each do |term|
       @recipes = @recipes.to_a.concat Recipe.where("lower(search_terms) LIKE '%#{term}%' or lower(name) LIKE '%#{term}%'
                          or description LIKE '%#{term}%'").order('updated_at DESC')
    end
  end

  private
    def fetch_nav
      @groups = Group.select("id","name")
      @ingredients = Ingredient.all
    end

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :url, :description, :search_terms, :image, recipeIngredient_attributes: [ingredient_attributes: [:id, :name]])
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username,password|
        username == "admin" && password == "password"
      end
    end

end
