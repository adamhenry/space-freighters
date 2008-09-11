class DashbordController < ApplicationController

	def index
		@spacestations = Spacestation.find(:all).reject{ |s| s == @ship.location }

			@route_max_name_length = max_length( @ship.location.routes.map{ |x| x.to }, :name )
			@route_max_distance_length = max_length( @ship.location.routes, :distance , true) 

		#Spacestation
			price_name = @ship.location.prices.map{ |x| x.sku }
			@price_max_name_length = max_length( price_name, :name )
			@price_max_length      = max_length( @ship.location.prices, :price )
			#raise "#{@price_max_length}: #{ @ship.location.prices.map{ |p| p.price }.join(": ") } "
	end

	def fly_to
		begin
		@ship.fly_to( destination = Spacestation.find( params[:destination] ) )
		rescue Ship::InsufficientFuel
			flash[:navigation_notice] =
					"You do not have enfough fuel to reach #{ destination.name }."
		rescue Ship::DestinationNotValid
			flash[:navigation_notice] =
			      "#{ destination.name } is not in the routes from #{ @ship.location.name }."
			      raise "#{ destination.name } is not in the routes from #{ @ship.location.name }."
		end
		redirect_to :action => :index
	end

	def store
		amount = params[:amount].to_i
		sku = Sku.find( params[:sku] )
		begin
			if params[:sale] == "buy"
				cargo = @ship.buy sku, amount
				flash[:station_notice] = "You have bought #{cargo.amount} unit#{ cargo.amount > 1 ? "s" : "" } of  #{sku.name}"
				redirect_to :action => :winner if cargo.name == "Retirement"
			elsif params[:sale] == "sell"
				sold = @ship.sell sku, amount
					flash[:station_notice] ="You have sold #{ sold } unit#{ sold > 1 ? "s" : "" } of #{ sku.name }."
				end
		rescue Ship::InsufficientFunds
			flash[:station_notice] = "You have insufficient funds to buy #{sku.name}"
		rescue Ship::DoesNotHaveThisCargo
			flash[:station_notice] = "You do not have #{sku.name} in your hold."
		end
		redirect_to :action => :index unless !cargo.nil? && cargo.name == "Retirement"
	end

	def winner
	end

	#returns the hightest number of caracters in symbol position in obj_array including , for large numbers
	def max_length obj_array, symbol, comma = nil
		obj_array.inject( 0 ) do |max, obj|
			length = obj[symbol].to_s.length + ( comma ? count_delimiters( obj[symbol] ) : 0 )
			#length = obj[symbol].to_s.length
			max >= length ? max : length
		end
	end

	def count_delimiters item
		( ( ( re = item.to_s.match( /(\d+)(\.(\d*)|)\b/ ) ) && re[1] ? re[1] : " " ).length - 1 ) / 3
	end
	
end
