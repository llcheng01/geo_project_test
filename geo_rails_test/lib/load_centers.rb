module LoadCenters
    def self.add_zcta_centroids
        count =0 
        Zcta.all.each do |z|
            # result = ActiveRecord::Base.connection.execute("SELECT st_astext(st_centroid('#{ z['region'] }'))")
            # wkt_parse = RGeo::WKRep::WKTParser.new.parse result[0]['st_astext']
            parser = RGeo::WKRep::WKTParser.new(nil, :support_ewkt => true)
            wkt_parse = parser.parse(z.region.as_text)
            center = wkt_parse.centroid
            puts "New RGeo WKRep center for #{z.zcta}: lng: #{center.x} lat: #{center.y}"
            z.center_lat = center.y
            z.center_lng = center.x
            z.save!
            puts "Record# #{count} "
            puts "center# lat: #{center.y} lng: #{center.x}"
            count += 1
        end
    end

    def self.add_location_centroids
        count = 0
        Location.all.each do |loc|
            parser = RGeo::WKRep::WKTParser.new(nil, :support_ewkt => true)
            polygon = parser.parse(loc.region.as_text)
            center = polygon.centroid
            loc.center_lat = center.y
            loc.center_lng = center.x
            loc.save!
            puts "Record# #{count} #{polygon.srid}"
            puts "Center# lat: #{center.y} lng: #{center.x}"
            count += 1
        end
    end

    def self.link_location_with_zip
        count = 0
        zips = []
        Location.all.each do |loc|
            wkt_point = "SRID=3785;POINT(#{loc.center_lng} #{loc.center_lat})"
            puts wkt_point
            zcta = Zcta.containing_wktpoint(wkt_point)
            puts "11: #{zcta.zcta}"
            zips << zcta["zcta"]
            puts "Record# #{count};"
            puts "#{loc.slug} has #{zips.inspect}"
            count += 1
        end
    end

end
