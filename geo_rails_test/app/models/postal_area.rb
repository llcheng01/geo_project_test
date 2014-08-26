class PostalArea < ActiveRecord::Base
  # attr_accessible :created_da, :location_id, :zcta_id
    belongs_to :location
    belongs_to :zcta
end
