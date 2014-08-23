class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :slug
      t.polygon :region, :srid => 3785

    end

    change_table :locations do |t|
        t.index :region, :spatial => true
    end
  end
end
