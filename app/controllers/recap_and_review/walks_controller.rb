class RecapAndReview::WalksController < ApplicationController
  def show
    # affichage de la synthèse de la walk + ajouter une review à l'itinéraire
    @walk = Walk.find(params[:id])
    @hotspots = @walk.hotspots
    @waypoints = @walk.waypoints
    if @waypoints.length.zero?
      @start_points = []
    else
      @start_points = [longitude: @waypoints.first.longitude, latitude: @waypoints.first.latitude]
    end
    @review = Review.new
  end
end
