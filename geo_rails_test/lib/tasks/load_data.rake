require 'rgeo/shapefile' 

desc "Load zcta data polygons"
task :load_zcta_data => :environment do
    LoadZctaData.load_data()
end

desc "Load Location data polygons"
task :load_location_data => :environment do
    LoadLocationData.load_data()
end

desc "Add Center to Location data"
task :add_location_centroids => :environment do
    LoadCenters.add_location_centroids()
end

desc "Add Center to zcta data"
task :add_zcta_centroids => :environment do
    LoadCenters.add_zcta_centroids()
end


desc "Link Center to zcta data"
task :link_location_with_zip  => :environment do
    LoadCenters.link_location_with_zip()
end
