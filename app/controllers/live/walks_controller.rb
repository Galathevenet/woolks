class Live::WalksController < ApplicationController
  def show
    # affichage de la carte en direct pour une walk avec ou non l'itinéraire + bouton stop
    @walk = Walk.find(params[:id])
    @hotspots = Hotspot.all
    @waypoints = @walk.original_walk.waypoints
  end
end
