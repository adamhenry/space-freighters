module DashbordHelper

	def space_up str
		while str != str.sub('  ', 'something')
			str.sub!('  ', '&nbsp ')
		end
		str
	end

	def decimal_align str, number
		str.match( /\s\d*\.(\d*)\b/ )[1].length.each do 
			"&nbsp" + str
		end
	end

end
