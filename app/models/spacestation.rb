class Spacestation < ActiveRecord::Base
	has_many   :routes,
	           :class_name => "Distance",
				  :foreign_key => "sp1"
	has_many :prices
end
