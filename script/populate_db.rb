#!/usr/bin/env ruby

#ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'  
#require File.expand_path(File.dirname(__FILE__) + "/../config/environment")  

Ship.destroy_all
Sku.destroy_all
Cargo.destroy_all
Spacestation.destroy_all
Price.destroy_all
Distance.destroy_all

s = Spacestation.create( :name => "Earth Dock 7" )
Spacestation.create( :name => "Mars Colony 2" )
Spacestation.create( :name => "Venus Gate" )
Spacestation.create( :name => "Asteroid Mind 11" )
 jt = Spacestation.create( :name => "Jupiter's Throne" )

ship = Ship.create( :name => "HMS Never Sinkable", :location => s, :fuel => 1000 )

spacestations = Spacestation.find(:all)
spacestations.each do |sp1|
	spacestations.reject { |sp| sp == sp1 }.each do |sp2|
		distance = rand( 10**5 ) / 1000.0 + 1 
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
		price = ( rand(300) + rand(300) + rand(300) ) * sku.size
		Price.create( :sku => sku, :spacestation => sp, :price => price ) unless price <= 0
	end
end
Price.create( :sku => re, :spacestation => jt, :price => 10**9 )
