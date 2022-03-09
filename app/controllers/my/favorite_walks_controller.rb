class Description::FavoriteWalksController < ApplicationController

  def create
    @favorite_walk = FavoriteWalk.new(favorite_walk_params)
    @current_walk = Walk.find(params[:walk_id])
    @favorite_walk.user = current_user
    @favorite_walk.save
    redirect_to description_walk_path(@favorite_walk.walk)
  end

  def destroy
    @favorite_walk = FavoriteWalk.find(params[:id])
    @favorite_walk.user = current_user
    @favorite_walk.destroy
    redirect_to my_walks_path
  end

  private

  def favorite_walk_params
    params.permit(:walk_id, :user_id)
  end
end
