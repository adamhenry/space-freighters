#!/usr/bin/env ruby

#ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'  
#require File.expand_path(File.dirname(__FILE__) + "/../config/environment")  

Ship.destroy_all
Sku.destroy_all
Cargo.destroy_all
Spacestation.destroy_all
Price.destroy_all
Distance.destroy_all

text = "Earth Dock 7 is only one out of over a thousand orbital space stations. The planet this station hangs over had produced and consumes almost an enter stellar system of goods in a single year. The ports are constantly busy  with traffic commerce. The tremendous population spills out millions of people new to the spaceways every year. The one grate cauldron of humanity."

s = Spacestation.create( :name => "Earth Dock 7", :description => text, :image => "4.jpg" )

text = "The second of six space stations acting as hubs for a words commerce. Mars Colony was Earth first non-terrestrial colony. Its burgeoning population second only to Earth. Over the long history of Mars it has always struggled under Earth as a Satiate state. Harsh labor laws and poor political representation of the working pore have left this planet in a constant state of turmoil."

Spacestation.create( :name => "Mars Colony 2", :description => text, :image => "1.jpg" )

text = "This singular space station stands over a verdant world. Although thought the closest earth like planet to earth the terraforming of its harsh atmosphere has taken an unordinate amount of time. With the late entry into interstellar development Venus has become an ecological oases of life that the Earth has long seance lost. The majority of humanity's food crops are grown below, however the vast amounts of tonnage is contracted out to large hullers."

Spacestation.create( :name => "Venus Gate", :description => text, :image => "2.jpg" )

text = "One of many asteroid mines that peeper the asteroid belt. Asteroid Mine 11 was depleted over a malinum ago and left abandoned. An industrious man calling himself Atlas purchased it and deemed it its own state. After a short time and a flood of Ayn Rand-ion immigrants Asteroid Mine 11 had become a tremendous center of commerce. Not soon after Earth's political establishment moved to take it over. Through for cite and an unusual political mind Atlas preemptively halted Earth's attempts. The threat that Asteroid Mine 11 and Mars Colony rebels might leverage each overs strengths to opose  Earth holds it in check."

Spacestation.create( :name => "Asteroid Mine 11", :description => text, :image => "3.jpg" )

text ="The center of luxury and pleasure Jupiter's Throne is the jewel of the Universe. The elite of the galaxy dream of retiring to this decadent palace. If, only,  you where some how able to afford it."

 jt = Spacestation.create( :name => "Jupiter's Throne", :description => text, :image => "5.jpg" )

ship = Ship.create( :name => "USS Super Freighter Ulysses", :location => s, :fuel => 100 )

spacestations = Spacestation.find(:all)
spacestations.each do |sp1|
  spacestations.reject { |sp| sp == sp1 }.each do |sp2|
    distance = rand( 10**4 ) / 1000.0 + 1 
    Distance.create( :sp1 => sp1.id, :sp2 => sp2.id, :distance => distance )
  end
end

sku = Sku.create( :name => "Square Pigs", :size => 0.2 )
Sku.create( :name => "Wheat", :size => 0.001 )
Sku.create( :name => "Ore", :size => 0.001 )
Sku.create( :name => "Titanium Bar", :size => 1.2 )
Sku.create( :name => "Mining Laser", :size => 5.3 )
re = Sku.create( :name => "Retirement", :size => 0 )
container = Sku.create( :name => "Cargo Container", :size => 25)
tank = Sku.create( :name => "Fuel Tank", :size => 100)

Cargo.create( :ship => ship, :amount => 1, :sku => container )
Cargo.create( :ship => ship, :amount => 1, :sku => tank )

skus = Sku.find(:all)
skus.each do |sku|
  spacestations.each do |sp|
    price = ( ( rand(30) + rand(30) + rand(30) )/3.0 + 60 ) * sku.size
    Price.create( :sku => sku, :spacestation => sp, :price => price ) unless price <= 0
  end
end
Price.create( :sku => re, :spacestation => jt, :price => 10**9 )
