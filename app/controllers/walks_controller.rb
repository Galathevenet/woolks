class WalksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # affichage map + carte nouvel itinéraire + grilles cartes
    # Delete walks with no waypoints
    # raise
    Walk.all.each do |walk|
      walk.destroy if walk.waypoints.empty?
    end
    @durations = {:less_than_fifteen => "less than 15 min",
      :less_than_thirty => "less than 30 min",
      :one_hour => "1 hour",
      :one_hour_thirty => "1 hour 30",
      :two_hours => "2 hours",
      :more_than_two => "more than hours"
    }
    @hotspots_filters = {
      :park_walks => "park",
      :fountain_walks => "fountain",
      :dispenser_walks => "dispenser"
    }

    @search_filters =
    if params[:durations]
      @walks = []
      params[:durations].each do |duration|
        @walks += Walk.where(published: true).send(duration)
      end
    @walks.uniq!
    elsif params[:hotspots_filters]
      @walks = []
      params[:hotspots_filters].each do |hotspot_filter|
      @walks += Walk.where(published: true).send(hotspot_filter)
      end
    @walks.uniq!
    elsif params[:durations] && params[:hotspots_filters]
      @walks = []
      params[:durations].each do |duration|
        @walks += Walk.where(published: true).send(duration)
      end
      params[:hotspots_filters].each do |hotspot_filter|
        @walks += Walk.where(published: true).send(hotspot_filter)
      end
    else
      @walks = Walk.where(published: true)
    end
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
