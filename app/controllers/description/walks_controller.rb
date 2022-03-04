class Description::WalksController < ApplicationController
  def show
    @walk = Walk.find(params[:id]) # Original walk
    @new_walk = Walk.new
  end
end
