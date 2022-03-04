class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:alert] = "Your review has been added"
      redirect_to walks_path and return
    else
      @walk = Walk.find(params[:review][:walk_id])
      render "recap_and_review/walks/show"
      # redirect_to recap_and_review_walk_path(@current_walk.id) and return
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :walk_id, :comment, :user_id, photos: [])
  end

end
