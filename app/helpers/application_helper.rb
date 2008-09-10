# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def number_with_delimiter(number, delimiter=",")
		number.to_s.gsub(/(\d)(?=\d{3}+(\.\d*)?\b)/, "\\1#{delimiter}")
	end

	def list_item_right_left name, varible
		render( :partial => "list_item",
					:locals => {
						:locals => varible,
						:left => name.to_s +  "_left",
						:right => name.to_s + "_right"
					}
				)
	end

end
