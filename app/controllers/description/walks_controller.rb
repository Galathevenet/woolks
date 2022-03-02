class Description::WalksController < ApplicationController
  def show
    @walk = Walk.find(params[:id])
  end
end
