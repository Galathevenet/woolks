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

    # if params[:durations]
    #   params[:durations].each do |hotspot_filter|
    #     case hotspot_filter
    #     when "less_than_fifteen" then sql += "duration <= 900"
    #     when "less_than_thirty" then sql += "duration <= 1800 AND duration > 900"
    #     when "one_hour" then sql += "duration <= 3600 AND duration > 1800"
    #     when "one_hour_thirty" then sql += "duration <= 5400 AND duration > 3600"
    #     when "two_hours" then sql += "duration <= 7200 AND duration > 5400"
    #     when "more_than_two" then sql += "duration > 7200"
    #     end
    #   end
    #   @walks = Walk.where(published: true).where("duration <= ?", min_duration, max_duration)
    # else
    #   @walks = Walk.where(published: true)
    # end

    # if params[:hotspots_filters]
    #   sql = "hotspots.category IN ("
    #   params[:hotspots_filters].each do |hotspot|
    #     case hotspot
    #     when "park_walks" then sql += "dog park"
    #     when "fountain_walks" then sql += "fountain"
    #     when "dispenser_walks" then sql += "dispenser"
    #     end
    #     sql += ", "
    #   end
    #   sql = sql.slice(..-3) # get rid of the last ", "
    #   sql += ") "
    #   @walks = @walks.send(:joins_hotspots).where(sql)
    # end



    # @walks = Walk
    #   .joins(:hotspots)
    #   .where(published: true)
    #   .where("duration BETWEEN ? AND ?", 0, 20 * 60)

    # @walks = @walks
    #   .where("hotspots.category = ?", "dog park")
    #   .group(:id)
      # .where("hotspots.category = ?", "dog park")
      # .where("hotspots.category = ?", "fountain")
      # .where(hotspot: ['dog park', 'fountain'])

    # if params[:durations]
    #   sql = ""
    #   params[:durations].each do |hotspot_filter|
    #     case hotspot_filter
    #     when "less_than_fifteen" then sql += "duration <= 900"
    #     when "less_than_thirty" then sql += "duration <= 1800 AND duration > 900"
    #     when "one_hour" then sql += "duration <= 3600 AND duration > 1800"
    #     when "one_hour_thirty" then sql += "duration <= 5400 AND duration > 3600"
    #     when "two_hours" then sql += "duration <= 7200 AND duration > 5400"
    #     when "more_than_two" then sql += "duration > 7200"
    #     end
    #     sql += " OR "
    #   end
    #   sql = sql.slice(..-4) # get rid of the last "OR "
    #   @walks = Walk.where(published: true).where(sql)
    # else
    #   @walks = Walk.where(published: true)
    # end

    # if params[:hotspots_filters]
    #   sql = "hotspots.category IN ("
    #   params[:hotspots_filters].each do |hotspot_filter|
    #     case hotspot_filter
    #     when "park_walks" then sql += "dog park"
    #     when "fountain_walks" then sql += "fountain"
    #     when "dispenser_walks" then sql += "dispenser"
    #     end
    #     sql += ", "
    #   end
    #   sql = sql.slice(..-3) # get rid of the last ", "
    #   sql += ") "
    #   @walks = @walks.send(:joins_hotspots).where(sql)
    # end

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
