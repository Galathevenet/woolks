class Description::WalksController < ApplicationController
  def show
    @walk = Walk.find(params[:id]) # Original walk
    @hotspots = @walk.hotspots
    @waypoints = @walk.waypoints
    @user = current_user

    @start_points = [
      longitude: @walk.waypoints.first.longitude,
      latitude:  @walk.waypoints.first.latitude
    ]
    @new_walk = Walk.new

    @hps = [] # Array that will contain the list of the hotspots categories of @walk
    @walk.hotspots.each do |h|
      case h.category
      when "dispenser" then @hps.push("fa-toilet-paper")
      when "dog park" then @hps.push("fa-dog")
      when "fountain" then @hps.push("fa-faucet")
      end
    end
  end
end
