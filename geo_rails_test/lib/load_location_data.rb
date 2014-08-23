module LoadLocationData
    def self.load_data
        d = Dir.new("/Users/user/Documents/shapefiles_by_market/Orlando/hood-west-orange-county/")
        shape_files = d.entries.select {|entry| entry =~ /.shp$/ }.map {|entry| "#{d.path}/#{entry}"}
        
        shape_files.each do |shape_file|
            RGeo::Shapefile::Reader.open(shape_file, :factory => Location::FACTORY) do |file|
                puts "File contains #{file.num_records} records."
                file.each do |record|
                    puts "Record number #{record.index}:"
                    loc_slug = record['slug'].to_s
                    loc_name = record['NAME'].to_s
                    puts "Neighborhood #{loc_slug.inspect} has #{record.geometry.num_geometries.inspect}:"
                    # The record geometry is a MultiPolygon. Iterate
                    # over its parts
                    count = 0
                    record.geometry.projection.each  do |poly|
                        begin
                            puts "Inserting poly##{count} for #{loc_slug} and name: #{loc_name}"
                            Location.create(:name => loc_name, :slug => loc_slug, :region => poly)
                            count += 1
                        rescue Exception => e
                            puts e.message
                            puts e.backtrace.inspect
                        end
                    end
                end
            end
        end
        
    end
end
