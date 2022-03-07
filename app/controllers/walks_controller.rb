class WalksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # affichage map + carte nouvel itinéraire + grilles cartes
    @walks = Walk.all
    @markers = @walks.map do |w|
      {
        lat: w.start_point_latitude,
        lng: w.start_point_longitude,
        image_url: helpers.asset_url("primarypin.png")
      }
    end
  end

  def new
    @walk = Walk.new
  end

  def create
    # création de la walk quand on appuie sur le bouton Go de description/walks
    original_walk = Walk.find(params['walk']['original_walk_id'])
    @walk = Walk.new(
      user: current_user,
      name: original_walk.name,
      description: original_walk.description,
      date: Date.today,
      duration: 0,
      length: 0,
      original_walk: original_walk)

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
      redirect_to my_walks_path
    else
      redirect_to edit_recap_and_save_walk_path
    end
  end

  def destroy
    # en tant qu'utilisateurice je peux destroy un de mes itinéraires
  end

  private

  def walk_params
    params.require(:walk).permit(:name, :description, :published, photos: [])
  end
end
