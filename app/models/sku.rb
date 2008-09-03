class Sku < ActiveRecord::Base
	has_many :cargos
	has_many :prices
end
