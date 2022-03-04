class Description::WalksController < ApplicationController
  def show
    @walk = Walk.find(params[:id]) # Original walk
    @new_walk = Walk.new

    @hps = []
    @walk.hotspots.each do |h|
      case h.category
      when "dispenser" then @hps.push("fa-trash-can")
      when "park" then @hps.push("fa-tree")
      when "fountain" then @hps.push("fa-faucet")
      end
    end
  end
end
