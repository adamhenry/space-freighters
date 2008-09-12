class DashbordController < ApplicationController

	def index
		@spacestations = Spacestation.find(:all).reject{ |s| s == @ship.location }
	end

	def introduction
	end

	def fly_to
		begin
		@ship.fly_to( destination = Spacestation.find( params[:destination] ) )
		rescue Ship::InsufficientFuel
			flash[:navigation_notice] = "You do not have enough fuel to reach #{ destination.name }."
		rescue Ship::DestinationNotValid
			flash[:navigation_notice] = "#{ destination.name } is not in the routes from #{ @ship.location.name }."
		end
		redirect_to :action => :index
	end

	def store
		amount = params[:amount].to_i
		sku = Sku.find( params[:sku] )
			if params[:sale] == "buy"
				begin
					cargo = @ship.buy sku, amount
					flash[:station_notice] =
						"You have bought #{cargo.amount} unit#{ cargo.amount > 1 ? "s" : "" } of  #{sku.name}"
				rescue Ship::InsufficientFunds
					flash[:station_notice] = "You have insufficient funds to buy #{sku.name}"
				else
				redirect_to :action => :winner if cargo.name == "Retirement"
				end
			elsif params[:sale] == "sell"
				begin
					sold = @ship.sell sku, amount
					flash[:station_notice] =
						"You have sold #{ sold } unit#{ sold > 1 ? "s" : "" } of #{ sku.name }."
				rescue Ship::DoesNotHaveThisCargo
					flash[:station_notice] = "You do not have #{sku.name} in your hold."
				end
			end
		redirect_to :action => :index unless !cargo.nil? && cargo.name == "Retirement"
	end

	def winner
	end

end
