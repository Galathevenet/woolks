class WalksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # affichage map + carte nouvel itinéraire + grilles cartes
    # Delete walks with no waypoints
    Walk.all.each do |walk|
      walk.destroy if walk.waypoints.empty?
    end

    @walks = Walk.where(published: true)
    @hotspots = Hotspot.all
    @waypoints = Waypoint.all

    @start_points = []
    @walks.each do |walk|
      @start_points.push(longitude: walk.waypoints.first.longitude, latitude: walk.waypoints.first.latitude)
    end
  end

  def new
    @new_walk = Walk.new
  end

  def create
    # création de la walk quand on appuie sur le bouton Go de description/walks
    if params['walk']['original_walk_id'] != ""
      original_walk = Walk.find(params['walk']['original_walk_id'])
      @walk = Walk.new(
        user: current_user,
        name: original_walk.name,
        description: original_walk.description,
        date: Date.today,
        duration: 0,
        length: 0,
        original_walk: original_walk
      )
    else
      @walk = Walk.new(
        user: current_user,
        name: "Your new walk name",
        description: "Your new walk description",
        date: Date.today,
        duration: 0,
        length: 0,
        original_walk: nil
      )
    end

    if @walk.save
      redirect_to live_walk_path(@walk)
    else
      raise
    end
  end

  def edit
    # en tant qu'utilisateurice je peux modifier la desc de mes itinéraires (notamment published/unpublished)
  end

  def update
    # met à jour la walk avec son nom, sa description, ses photos...
  end

  def destroy
    # en tant qu'utilisateurice je peux destroy un de mes itinéraires
  end
end
