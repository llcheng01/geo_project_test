class CreatePostalAreas < ActiveRecord::Migration
  def self.up
      create_table :postal_areas, :id => false  do |t|
      t.integer :location_id
      t.integer :zcta_id
      t.datetime :created_dt
    end
    add_index :postal_areas, [:location_id, :zcta_id]
    add_index :postal_areas, :zcta_id
  end

  def self.down
      drop_table :postal_areas
  end
end
