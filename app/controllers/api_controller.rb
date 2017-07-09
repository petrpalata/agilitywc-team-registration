class ApiController < ApplicationController
    def countries
        teamleaders = User.where(show_country: true).where(role_cd: 2)
        team_countries = teamleaders.map do |tleader| 
            c = country_by_number(tleader.country_id)
            {
                :code => c.alpha2,
                :cs_translation => c.translation(:cs),
                :en_translation => c.translation(:en)
            }
        end
        render :json => team_countries
    end

    def country_teams
        country = Country[params[:country]]
        if country.nil?
            render :status => 404
        else
            render :json => Team.where(country_id: country.number.to_i)
        end
    end

    private
    def country_by_number(number)
        number_str = number.to_s
        Country.find_country_by_number("0" * (3 - number_str.length) + number_str)
    end
end
