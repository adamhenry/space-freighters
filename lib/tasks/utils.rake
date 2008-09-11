namespace :utils do
	desc "List all ships with there stats"
	task(:list_ship_stats => :environment) do
		
		ships = Ship.find(:all)

		name_padding = ships.inject(0){ |max, n| max > n.name.length ? max : n.name.length }
		for ship in ships
			puts sprintf("%*s: %6.2f%% %d",
			                              name_padding, ship.name,
													ship.total_cargo/ship.max_cargo,
													ship.max_cargo )
		end

	end
end
namespace :db do
	desc "Populate Develipment Database of SpaceTruckers"
	task(:populate => :environment) do

		require File.expand_path(File.dirname(__FILE__) + "/../../script/populate_db.rb")  

	end

end

