class Live::WalksController < ApplicationController
  def show
    # affichage de la carte en direct pour une walk avec ou non l'itinéraire + bouton stop
    
    # :id is the id of the current walk
    @walk = Walk.find(params[:id])
    @hotspots = Hotspot.all
    @waypoints = @walk.original_walk.waypoints
  end
end
