class Ship < ActiveRecord::Base
	belongs_to :location,
				  :foreign_key => "location_id",
				  :class_name => "Spacestation"
	has_many :cargo

	class InsufficientFunds < Exception; end
	class InsufficientFuel < Exception; end
	class DoesNotHaveThisCargo < Exception; end
	class DestinationNotValid < Exception; end

	def fuel_capacity
		tank = cargo.select{ |c| c.name == "Fuel Tank"}
		50  + ( !( tank.empty? ) ? tank[0].size * tank[0].amount : 0 )
	end

	def free_cargo
		max_cargo - total_cargo
	end

	def total_cargo
		cargo.inject( 0 ){ |total, c| total += c.amount * c.sku.size }.to_f
	end

	def cargo_containers
		cargo.select{ |c| c.name =="Cargo Container" }
	end

	def max_cargo
		container = cargo_containers
		100 + ( !( container.empty? ) ? container[0].size * container[0].amount : 0 )
	end

	def total_weight
		512 + total_cargo
	end

	def total_length
		120 + 80 * cargo_containers.length
	end
	
	def total_cargo
		units = cargo.reject{ |c| ( c.name != "Cargo Container"  ) && ( c.name != "Fuel Tank" ) }
		units.inject(0){ | total , unit | total =+ unit.size}
	end

	def fly_to destination
		raise DestinationNotValid if self.location.routes.select{ |r| r.to == destination }.empty?
		fuel_spent = self.location.routes.select{ |r| r.to == destination }[0].distance
		raise InsufficientFuel unless self.fuel - fuel_spent >= 0
		self.fuel -= fuel_spent
		self.location = destination
		save
	end

	def set_buy_max_or_not sku, amount
		amount.to_i
		max = ( self.fuel / sku_price(sku) ).floor
		max = max < 1 ? 1 : max
		amount == 0 ? amount = max : amount
	end

	def sku_price sku
		self.location.prices.select{ |p| p.sku == sku }[0].price
	end

	def add_cargo sku, amount
		merchandise = get_sku_in_cargo( sku )
		if merchandise.empty?
			Cargo.create( :sku => sku, :ship => self, :amount => amount )
		else
			Cargo.update( merchandise[0].id, :amount => ( merchandise[0].amount + amount ) )
		end
	end

	def deduct_price price
		raise InsufficientFunds unless self.fuel - price >= 0
		self.fuel -= price
		self.save
	end

	def buy sku, amount
		amount = set_buy_max_or_not( sku, amount )
		deduct_price( amount * sku_price( sku ) )
		add_cargo( sku, amount )
	end

	def total_sku_in_cargo sku
		self.cargo.select{ |i| i.sku == sku }.map{ |i| i.amount }.inject(0){|total, i| total += i }
	end

	def set_sale_max_or_not amount, sku
		# if the amount is not a valid amount assume all
		has = total_sku_in_cargo sku
		( has > amount ) && ( 0 < amount ) ? amount : has
	end

	def get_sku_in_cargo sku
		self.cargo.select { |i| i.sku == sku }
	end

	def sell_partial_cargo_unit item, amount
		Cargo.update( item.id, :amount => ( item.amount - amount ) )
		self.fuel += amount * sku_price( item.sku )
		self.save
		amount
	end

	def sell_enter_cargo_unit item
		amount = item.amount
		self.fuel += amount * sku_price( item.sku )
		self.save
		item.destroy
		item = []
		amount
	end

	def sell_cargo sku, amount
		merchendice = get_sku_in_cargo sku
		sold = 0
		for item in merchendice
			break if amount == sold
			if item.amount > amount - sold
				sold += sell_partial_cargo_unit( item, amount )
			else
				sold += sell_enter_cargo_unit( item )
			end
		end
		sold
	end

	def sell sku, amount
		amount = set_sale_max_or_not( amount.to_i, sku )
		raise DoesNotHaveThisCargo if amount == 0
		sell_cargo sku, amount
	end

end
