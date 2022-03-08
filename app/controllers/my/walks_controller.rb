class My::WalksController < ApplicationController
  def index
    # 3 onglets avec mes favoris, mes itinéraires créés, mon historique
    @published_walks = Walk.where(user: current_user, published: true)
    @favorite_walks = #Walk.includes(:favorite_walks).where(favorite_walks: {user: current_user})
    @history_walks = Walk.where(user: current_user)
    @hotspots = Hotspot.all
    @waypoints = Waypoint.all
  end

  def destroy
    @walk = Walk.find(params[:id])
    @walk.destroy
    flash[:alert] = "Your walk has been deleted"
    redirect_to my_walks_path
  end
end
