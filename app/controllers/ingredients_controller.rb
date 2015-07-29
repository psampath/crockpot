class IngredientsController < ApplicationController
  before_action :fetch_nav
  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Your Ingredient was created succesfully"
      redirect_to ingredients_path
    else
      render :new
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  private
    def fetch_nav
      @groups = Group.select("id","name")
      @ingredients = Ingredient.all
    end

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

end
