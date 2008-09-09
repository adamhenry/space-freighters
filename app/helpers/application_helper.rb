# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def number_with_delimiter(number, delimiter=",")
		number.to_s.gsub(/(\d)(?=\d{3}+(\.\d*)?\b)/, "\\1#{delimiter}")
	end

end
