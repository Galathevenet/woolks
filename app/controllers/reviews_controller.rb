class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    # create une review quand elle est validée par l'utilisateurice
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to(walk_path(@walk))
    else
      render :new
    end
    # @walk = Walk.find(params[:walk_id])
  end

  private

  def review_params
    params.require(:review).permit(:rating, :walk_id, :comment, :user_id, photos: [])
  end

end
