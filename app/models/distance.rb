class Distance < ActiveRecord::Base
	belongs_to :from,
	           :class_name => "Spacestation",
				  :foreign_key => "sp1"
	belongs_to :to,
	           :class_name => "Spacestation",
				  :foreign_key => "sp2"
end
