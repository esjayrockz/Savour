class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_dish
  before_action :authenticate_user!
  before_filter { |c| c.action_name == "new" && c.confirm_user_type(Foodie) }

  def new
    #@review = Review.new
    @review = current_user.reviews.build
  end


  def create
    @review = current_user.reviews.build(review_params)
    @review.dish_id = @dish.id

    if @review.save
      redirect_to @dish
    else
      render 'new'
    end
  end



  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @dish
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to @dish
  end



  private

    def set_review
      @review = Review.find(params[:id])
    end

    def set_dish
       @dish = Dish.find(params[:dish_id])
    end

    def review_params
    params.require(:review).permit(:rating, :comment)
    end

  end
