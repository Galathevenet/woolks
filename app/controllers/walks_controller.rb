class WalksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # affichage map + carte nouvel itinéraire + grilles cartes balades
  end

  def new
    @walk = Walk.new
  end

  def create
    # création de la walk quand on appuie sur le bouton Go de description/walks
  end

  def edit
    # en tant qu'utilisateurice je peux modifier la desc de mes itinéraires (notamment published/unpublished)
  end

  def update
    # appuie sur bouton fin de la walk à la fin de mon parcours
  end

  def destroy
    # en tant qu'utilisateurice je peux destroy un de mes itinéraires
  end
end
