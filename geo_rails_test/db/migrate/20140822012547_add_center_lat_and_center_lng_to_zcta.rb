class AddCenterLatAndCenterLngToZcta < ActiveRecord::Migration
  def change
    add_column :zcta, :center_lat, :float
    add_column :zcta, :center_lng, :float
  end
end
