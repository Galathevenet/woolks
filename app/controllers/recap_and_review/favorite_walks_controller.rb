class RecapAndReview::FavoriteWalksController < ApplicationController

  def create
    @favorite_walk = FavoriteWalk.new
    @walk = Walk.find(params[:walk_id])
    @favorite_walk.user = current_user
    @favorite_walk.walk = @walk.original_walk
    @review = Review.new
    if @favorite_walk.save
      flash[:alert] = "Your walk has been added to favorite"
      redirect_to recap_and_review_walk_path(@walk)
    else
    end
  end

  def destroy
    @walk = Walk.find(params[:id])
    @favorite_walk = FavoriteWalk.find(params[:walk_id])
    @favorite_walk.user = current_user
    @review = Review.new
    if @favorite_walk.destroy
      flash[:alert] = "Your walk has been deleted from favorite"
      redirect_to recap_and_review_walk_path(@walk)
    else
    end
  end
end
