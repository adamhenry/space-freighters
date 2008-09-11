# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '750186ac07c886d4382fc8f3e1cb9367'

  before_filter :check_database

  def check_database
  		begin
			@ship = Ship.find(:first)
			if @ship.nil?
				redirect_to :action => :db_populate, :controller => :initialize
			end
		rescue Object => e
		#rescue SQLite3::SQLException => e
			redirect_to :action => :db_initialize, :controller => :initialize
		end
  end
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
