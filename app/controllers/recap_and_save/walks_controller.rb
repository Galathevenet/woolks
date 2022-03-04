class RecapAndSave::WalksController < ApplicationController
  def show
    # j'affiche la synthèse de ma walk et proposition de sauvegarder ou de la supprimer
  end

  def edit
    # Si j'ai décidé de sauvegarder ma walk, j'ajoute une desc, des photos etc
    @walk = Walk.find(params[:id])
    @hotspots = @walk.hotspots
    @waypoints = @walk.waypoints
    @start_points = [longitude: @waypoints.first.longitude, latitude: @waypoints.first.latitude]
  end
end
