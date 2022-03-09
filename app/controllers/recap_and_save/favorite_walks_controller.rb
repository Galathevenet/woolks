class RecapAndSave::FavoriteWalksController < ApplicationController

  def create
    @favorite_walk = FavoriteWalk.new
    @walk = Walk.find(params[:walk_id])
    @favorite_walk.user = current_user
    @favorite_walk.walk = @walk
    if @favorite_walk.save
      flash[:alert] = "Your walk has been added to favorite"
      redirect_to edit_recap_and_save_walk_path(@walk)
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
      redirect_to edit_recap_and_save_walk_path(@walk)
    else
    end
  end
end
