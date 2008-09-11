class InitializeController < ApplicationController

	skip_before_filter :check_database

	def db_populate
	end

	def db_initialize
	end
	
end
