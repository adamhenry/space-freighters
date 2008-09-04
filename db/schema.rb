# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080805041034) do

  create_table "cargos", :force => true do |t|
    t.integer  "ship_id"
    t.integer  "sku_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distances", :force => true do |t|
    t.integer  "sp1"
    t.integer  "sp2"
    t.decimal  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", :force => true do |t|
    t.integer  "sku_id"
    t.integer  "spacestation_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ships", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.integer  "fuel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skus", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "type"
    t.decimal  "size"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spacestations", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
