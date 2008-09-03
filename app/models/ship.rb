class Ship < ActiveRecord::Base
	belongs_to :location,
				  :foreign_key => "location",
				  :class_name => "Spacestation"
	has_many :cargo
end
