module LoadZctaData
    def self.load_data
        d = Dir.new("/Users/user/Downloads/tl_2013_us_zcta510/")
        shape_files = d.entries.select {|entry| entry =~ /.shp$/ }.map {|entry| "#{d.path}/#{entry}"}
        
        shape_files.each do |shape_file|
            RGeo::Shapefile::Reader.open(shape_file, :factory => Zcta::FACTORY) do |file|
                puts "File contains #{file.num_records} records."
                file.each do |record|
                    puts "Record number #{record.index}:"
                    zcta = record['ZCTA5CE10'].to_i
                    puts "Zip Code #{zcta.inspect} has #{record.geometry.num_geometries.inspect}:"
                    # The record geometry is a MultiPolygon. Iterate
                    # over its parts
                    count = 0
                    record.geometry.projection.each  do |poly|
                        begin
                            puts "Inserting poly##{count} for #{zcta}"
                            Zcta.create(:zcta => zcta, :region => poly)
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
