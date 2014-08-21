class ZctaController < ApplicationController

    def lookup
        lat = params[:lat].to_f
        lon = params[:lon].to_f
        zcta = Zcta.containing_latlon(lat, lon).first
        render(:json => {:lat => lat, :lon => lon, 
            :zcta => zcta ? zcta.zcta : nil})
    end

    def getPolygon
        as_json = {}
        zip = params[:zip]
        zcta = Zcta.find_by_zcta(zip)
        as_json = get_as_json zcta 
        puts "JSON: #{as_json.inspect}"
        # respond_to do |format|
        #     format.json {render :json => as_json.to_json}
        # end
        render(:json => as_json )
    end

    private 
        def get_as_json region
            hash1 = {}
            unless region.nil?
              # polygon_hash = JSON.parse(region["region"])
                polygon_hash = RGeo::GeoJSON.encode(region.reg_geographic)
              hash1 = {
                        :id      => region["id"],
                        :name    => region["zcta"],
                        :polygon => polygon_hash,
                        :status  => 200
                      }
              { region["zcta"] => hash1 }
            else
              hash1 = {
                        :status => 200,
                        :error  => "the hood or region was not found."
                      }
              { :error => hash1 }
            end
        end
end
