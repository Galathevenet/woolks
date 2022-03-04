class Description::WalksController < ApplicationController
  def show
    @walk = Walk.find(params[:id]) # Original walk
    @hotspots = @walk.hotspots
    @waypoints = @walk.waypoints

    @start_points = [
      longitude: @walk.waypoints.first.longitude,
      latitude:  @walk.waypoints.first.latitude
    ]
    @new_walk = Walk.new
  end
end
