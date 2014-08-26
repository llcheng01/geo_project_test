# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140825231857) do

  create_table "locations", :force => true do |t|
    t.string  "name"
    t.string  "slug"
    t.spatial "region",     :limit => {:srid=>3785, :type=>"polygon"}
    t.float   "center_lat"
    t.float   "center_lng"
  end

  add_index "locations", ["region"], :name => "index_locations_on_region", :spatial => true

  create_table "postal_areas", :id => false, :force => true do |t|
    t.integer  "location_id"
    t.integer  "zcta_id"
    t.datetime "created_dt"
  end

  add_index "postal_areas", ["location_id", "zcta_id"], :name => "index_postal_areas_on_location_id_and_zcta_id"
  add_index "postal_areas", ["zcta_id"], :name => "index_postal_areas_on_zcta_id"

  create_table "zcta", :force => true do |t|
    t.integer "zcta"
    t.spatial "region",     :limit => {:srid=>3785, :type=>"polygon"}
    t.float   "center_lat"
    t.float   "center_lng"
  end

  add_index "zcta", ["region"], :name => "index_zcta_on_region", :spatial => true

end
