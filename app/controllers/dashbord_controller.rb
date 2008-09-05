class DashbordController < ApplicationController

	def index
		@ship = Ship.find :first
		@spacestations = Spacestation.find(:all).reject{ |s| s == @ship.location }
		@skus = Sku.find :all
	end

	def fly_to
		@ship = Ship.find :first
		@ship.fly_to Spacestation.find( params[:destination] ) 
		redirect_to :action => :index
	end

	def store
		@ship = Ship.find :first
		if params[:sale] == "buy"
			@ship.buy Sku.find( params[:sku] )
		elsif params[:sale] == "sell"
			@ship.sell Sku.find( params[:sku] )
		end
		redirect_to :action => :index
	end
end
