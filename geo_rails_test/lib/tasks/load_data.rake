require 'rgeo/shapefile' 

desc "Load zcta data polygons"
task :load_zcta_data => :environment do
    LoadZctaData.load_data()
end
