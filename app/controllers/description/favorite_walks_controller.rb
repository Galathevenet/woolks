class My::FavoriteWalksController < ApplicationController

  def create
    @favorite_walk = FavoriteWalk.new(favorite_walk_params)
    @current_walk = Walk.find(params[:walk_id])
    @favorite_walk.user = current_user
    if @favorite_walk.save
      flash[:alert] = "Your walk has been added to favorite"
      redirect_to description_walk_path(@favorite_walk.walk)
    else
    end
  end

  def destroy
    @favorite_walk = FavoriteWalk.find(params[:walk_id])
    @favorite_walk.user = current_user
    if @favorite_walk.destroy
      flash[:alert] = "Your walk has been deleted from favorite"
      redirect_to description_walk_path(@favorite_walk.walk)
    else
    end
  end

  private

  def favorite_walk_params
    params.permit(:walk_id, :user_id)
  end
end
