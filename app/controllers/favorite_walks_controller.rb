class FavoriteWalksController < ApplicationController

  def create
    @favorite_walk = FavoriteWalk.new
    @walk = Walk.find(params[:walk_id])
    @favorite_walk.user = current_user
    @favorite_walk.walk = @walk
    if @favorite_walk.save!
      flash[:alert] = "Your walk has been added to favorite"
      redirect_to walks_path
    else
    end
  end

  def destroy
    @favorite_walk = FavoriteWalk.find(params[:id])
    @favorite_walk.user = current_user
    if @favorite_walk.destroy
      flash[:alert] = "Your walk has been deleted from favorite"
      redirect_to walks_path
    else
    end
  end
end
