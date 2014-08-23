class AddCenterLatAndCenterLngToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :center_lat, :float
    add_column :locations, :center_lng, :float
  end
end
