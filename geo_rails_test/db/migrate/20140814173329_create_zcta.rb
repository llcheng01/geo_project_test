class CreateZcta < ActiveRecord::Migration
  def change
    create_table :zcta do |t|
      t.integer :zcta
      t.polygon :region, :srid => 3785
    end

    change_table :zcta do |t|
      t.index :region, :spatial => true
    end
  end
end
