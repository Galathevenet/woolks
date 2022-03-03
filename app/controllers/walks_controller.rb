class WalksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # affichage map + carte nouvel itinéraire + grilles cartes balades
  end

  def new
    # page avant la création d'un nouvel itinéraire
  end

  def create
    # création de la walk quand on appuie sur le bouton Go de description/walks
  end

  def edit
    # en tant qu'utilisateurice je peux modifier la desc de mes itinéraires (notamment published/unpublished)
  end

  def update
    # appuie sur bouton fin de la walk à la fin de mon parcours
    @walk = Walk.find(params[:id])
    # From: "2.3522219,48.856614,2.3522219,48.856614,2.3522219,48.856614"
    # To: [[2.3522219, 48.856614], [2.3522219, 48.856614], [2.3522219, 48.856614]]
    params['walk']['waypoints'].split(',').map(&:to_f).each_slice(2).to_a.each do |coord|
      Waypoint.create!(walk: @walk, longitude: coord[0], latitude: coord[1])
    end
    # IS IT HERE OR IN waypoints_controller.rb ?
  end

  def destroy
    # en tant qu'utilisateurice je peux destroy un de mes itinéraires
  end
end
