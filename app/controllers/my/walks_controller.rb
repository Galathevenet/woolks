class My::WalksController < ApplicationController
  def index
    # 3 onglets avec mes favoris, mes itinéraires créés, mon historique
    @published_walks = Walk.where(user: current_user, published: true)
    @favorite_walks = FavoriteWalk.where(user: current_user).map { |fwalk| fwalk.walk }
    @history_walks = Walk.where(user: current_user)
    @hotspots = Hotspot.all
    @waypoints = Waypoint.all
    if @waypoints.length.zero?
      @start_points = []
    else
      @start_points = [longitude: @waypoints.first.longitude, latitude: @waypoints.first.latitude]
    end
  end

  def destroy
    @walk = Walk.find(params[:id])
    @walk.destroy
    flash[:alert] = "Your walk has been deleted"
    redirect_to my_walks_path
  end
end
