class Price < ActiveRecord::Base
	belongs_to :sku, :readonly => :true
	belongs_to :spacestation, :readonly => :true
end
