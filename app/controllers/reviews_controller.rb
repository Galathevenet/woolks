class ReviewsController < ApplicationController

  # def new
  #   @review = Review.new
  # end

  def create
    @review = Review.new(review_params)
    @current_walk = Walk.find(params[:review][:current_walk_id])
    @review.user = current_user
    if @review.save
      flash[:alert] = "Your review has been added"
      redirect_to description_walk_path(@review.walk) #and return
    else
      # @walk = Walk.find(params[:review][:walk_id])
      # render "recap_and_review/walks"
      redirect_to recap_and_review_walk_path(@current_walk) #and return
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :walk_id, :comment, photos: [])
  end

end
