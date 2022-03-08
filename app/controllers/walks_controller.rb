class WalksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # affichage map + carte nouvel itinéraire + grilles cartes
    # Delete walks with no waypoints
    # raise
    Walk.all.each do |walk|
      walk.destroy if walk.waypoints.empty?
    end
    @durations = {
      less_than_fifteen: "Up to 15 min",
      less_than_thirty: "15 to 30 min",
      one_hour: "30 min to 1 hour",
      one_hour_thirty: "1h to 1h30",
      two_hours: "1h30 to 2h",
      more_than_two: "More than 2h"
    }
    @hotspots_filters = {
      park_walks: "Dog park",
      fountain_walks: "Fountain",
      dispenser_walks: "Dispenser"
    }

    @search_filters =
      if params[:durations] && params[:hotspots_filters]
        @walks = []
        params[:durations].each do |duration|
          @walks += Walk.where(published: true).send(duration)
        end
        params[:hotspots_filters].each do |hotspot_filter|
          @walks += Walk.where(published: true).send(hotspot_filter)
        end
      elsif params[:durations]
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
      else
        @walks = Walk.where(published: true)
      end

    @hotspots = Hotspot.all
    @waypoints = Waypoint.all

    @start_points = []
    @walks.each do |walk|
      @start_points.push(
        longitude: walk.waypoints.first.longitude,
        latitude: walk.waypoints.first.latitude,
        info_window: render_to_string(partial: "info_window", locals: { walk: walk })
      )
    end
  end

  def new
    @new_walk = Walk.new
    @hotspots = Hotspot.all
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
    @walk = Walk.find(params[:id])
    if @walk.update(walk_params)
      flash[:alert] = "Your walk has been saved"
      redirect_to my_walks_path
    else
      # redirect_to edit_recap_and_save_walk_path
      @hotspots = @walk.hotspots
      @waypoints = @walk.waypoints
      @start_points = [longitude: @waypoints.first.longitude, latitude: @waypoints.first.latitude]
      render "recap_and_save/walks/edit"
    end
  end

  def destroy
    # en tant qu'utilisateurice je peux destroy un de mes itinéraires
    @walk = Walk.find(params[:id])
    @walk.destroy
    redirect_to walks_path
  end

  private

  def walk_params
    params.require(:walk).permit(:name, :description, :published, photos: [])
  end
end
