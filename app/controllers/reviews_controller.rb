class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to(walks_path) and return
    else
      redirect_to(recap_and_review_walks(@walk)) and return
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :walk_id, :comment, :user_id, photos: [])
  end

end
