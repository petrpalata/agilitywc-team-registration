class Payment < ActiveRecord::Base
    attr_accessible :country_id, :price_in_euros, :total_teams, :total_assistants_coaches
    validates_presence_of :country_id, :price_in_euros, :total_teams, :total_assistants_coaches
    validates_uniqueness_of :country_id
end
