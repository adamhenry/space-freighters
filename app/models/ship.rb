class Ship < ActiveRecord::Base
	belongs_to :location,
				  :foreign_key => "location_id",
				  :class_name => "Spacestation"
	has_many :cargo

	def max_cargo
		contaners = cargo.reject{ |c| c.name != "Cargo Contaner"}
		contaners[0].size.to_f
	end

	def total_cargo
		units = cargo.reject{ |c| ( c.name != "Cargo Contaner"  ) && ( c.name != "Fuel Tank" ) }
		units.inject(0){ | total , unit | total =+ unit.size}
	end

	def fly_to destination
		self.location = destination
		save
	end

	def buy sku
		self.cargo << Cargo.new( :sku => sku, :ship => self, :amount => 1 )
	end

	def sell sku
		self.cargo.reject! do |item|
			if item.sku == sku
				item.destroy
			end
			item.sku == sku
		end
	end

end
