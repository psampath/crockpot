class GroupsController < ApplicationController
  before_action :fetch_nav

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Your Group was created succesfully"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  private
    def fetch_nav
      @groups = Group.select("id","name")
      @ingredients = Ingredient.all
    end

    def group_params
      params.require(:group).permit(:name)
    end
end
