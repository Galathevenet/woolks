class Live::WalksController < ApplicationController
  def show
    # affichage de la carte en direct pour une walk avec ou non l'itinéraire + bouton stop

    # :id is the id of the current walk
    @walk = Walk.find(params[:id])
    @hotspots = Hotspot.all
    @waypoints = @walk.original_walk.waypoints
  end

  def update
    @walk = Walk.find(params[:id])
    # From: "2.3522219,48.856614,2.3522219,48.856614,2.3522219,48.856614"
    # To: [[2.3522219, 48.856614], [2.3522219, 48.856614], [2.3522219, 48.856614]]
    params['walk']['waypoints'].split(',').map(&:to_f).each_slice(2).to_a.each do |coord|
      Waypoint.create!(walk: @walk, longitude: coord[0], latitude: coord[1])
    end
  end
end
