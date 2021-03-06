class DishesController < ApplicationController
  before_action :find_dish, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show, :search, :caro]
  before_filter { |c| c.action_name == "new" && c.confirm_user_type(Restaurant)}
  before_filter { |c| c.action_name == "restaurant_profile" && c.confirm_user_type(Restaurant) }
  before_filter { |c| c.action_name == "user_profile" && c.confirm_user_type(Foodie) }
  before_filter { |c| c.action_name == "rate" && c.confirm_user_type(Foodie) }
  before_filter { |c| c.action_name == "admin" && c.confirm_user_type(Admin) }

  def index
    @dishes = Dish.joins('LEFT JOIN reviews ON dishes.id = reviews.dish_id').
    select("dishes.image_file_name,dishes.id,dishes.dish,dishes.user_id, avg(ifnull(reviews.rating,0)) as average_rating, count(reviews.id) as number_of_reviews").group("dishes.id").order("average_rating DESC, number_of_reviews DESC").limit(10)
  end

  def rate
  end

  def admin
  @users = User.all
  end

  def user_profile
    @reviews = Review.where(user_id: current_user.id).order("created_at DESC")
  end

  def restaurant_profile
  @dishes =  Dish.joins('LEFT JOIN reviews ON dishes.id = reviews.dish_id').
    select("dishes.image_file_name,dishes.id,dishes.dish,dishes.cuisine, avg(ifnull(reviews.rating,0)) as average_rating, count(reviews.id) as number_of_reviews").where(user_id: current_user.id).group("dishes.id").order("average_rating DESC, number_of_reviews DESC")


  end

  def search
    if params[:search].present?
      @dishes = Dish.search(params[:search])
    else
      @dishes = Dish.all
    end
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
    @reviews = Review.where(dish_id: @dish.id).order("created_at DESC")

    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
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
    params.require(:dish).permit(:dish, :cuisine, :category, :image)
  end
end
