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
    raise
    # IS IT HERE OR IN waypoints_controller.rb ?
    
    # Loop on coordinates and add waypoints
    # Waypoint.create!(walk: @walk, longitude: , latitude: )

    # if @walk.update()
    #   redirect_to recap_and_review_walk_path(@walk)
    # else
    #   redirect_to walks_path # SHOULD PRINT AN ERROR
    # end
  end

  def destroy
    # en tant qu'utilisateurice je peux destroy un de mes itinéraires
  end
end
