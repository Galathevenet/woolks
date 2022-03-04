class RecapAndReview::WalksController < ApplicationController
  def show
    # affichage de la synthèse de la walk + ajouter une review à l'itinéraire
    @walk = Walk.find(params[:id])
    @review = Review.new
  end

end
