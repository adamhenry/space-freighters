class Cargo < ActiveRecord::Base
	belongs_to :ship
	belongs_to :sku

	# a cargos name is that of its sku
	def name
		sku.name
	end

	#size returns the enter size of the cargo. If size of an indiviual sku is neede sku.size is suficent
	def size
		sku.size * amount
	end

end
