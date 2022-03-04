class RecapAndReview::WalksController < ApplicationController
  def show
    # affichage de la synthèse de la walk + ajouter une review à l'itinéraire
    @walk = Walk.find(params[:id])
    @hotspots = @walk.hotspots
    @waypoints = @walk.waypoints
    @start_points = [longitude: @waypoints.first.longitude, latitude: @waypoints.first.latitude]
    @review = Review.new
  end
end
