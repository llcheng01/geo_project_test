class Location < ActiveRecord::Base
  attr_accessible :name, :region, :slugA
  has_many :postal_areas
  has_many :zctas, :through => :postal_areas

  FACTORY = RGeo::Geographic.simple_mercator_factory
    set_rgeo_factory_for_column(:region, FACTORY.projection_factory)

    # Generator for POSTGIS's native language
    EWKB = RGeo::WKRep::WKBGenerator.new(:type_format => :ewkb,
            :emit_ewkb_srid => true, :hex_format => true)

    # Interact in projected coordinates
    def reg_projected
        self.region
    end

    def reg_projected=(value)
        self.region = value
    end

    # To use geographic (lat/lon) coordinates, 
    # convert them using the wrapper factory
    def reg_geographic
        FACTORY.unproject(self.region)
    end

    def reg_geographic=(value)
        self.region = FACTORY.project(value)
    end

    def self.containing_latlon(lat, lon)
        ewkb = EWKB.generate(FACTORY.point(lon, lat).projection)
        where("ST_Intersects(region, ST_GeomFromEWKB(E'\\\\x#{ewkb}'))")
    end

    def self.containing_geom(geom)
        ewkb = EWKB.generate(FACTORY.projection(geom))
        where("ST_Intersects(region, ST_GeomFromEWKB(E'\\\\x#{ewkb}'))")
    end
end
