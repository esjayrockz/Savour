class DishesController < ApplicationController
  before_action :find_dish, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  def index
    @dishes = Dish.all.order("rating DESC")
  end

  def new
    #@dish = Dish.new
    @dish = current_user.dishes.build
  end

  def create
    @dish = current_user.dishes.build(dish_params)

    if @dish.save
      redirect_to @dish
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      redirect_to @dish
    else
      render 'edit'
    end
  end

  def destroy
    @dish.destroy
    redirect_to root_path
  end

  private

  def find_dish
      @dish = Dish.find(params[:id])
    end

  def dish_params
    params.require(:dish).permit(:dish, :cuisine, :category)
  end
end
