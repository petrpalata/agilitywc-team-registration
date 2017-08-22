class ApiController < ApplicationController
    def countries
        teamleaders = User.where(confirm_all: true, show_country: true, role_cd: 2).select(:country_id).uniq
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
            render :nothing => true, :status => 404
        else
            teamleader = User.where(country_id: country.number, show_country: true, role_cd: 2, confirm_all: true).first
            if teamleader.nil?
                render :nothing => true, :status => 404
            else
                render :json => compose_country_team(teamleader)
            end
        end
    end

    private
    def country_by_number(number)
        number_str = number.to_s
        Country.find_country_by_number("0" * (3 - number_str.length) + number_str)
    end

    def compose_country_team(teamleader)
        country_team = Hash.new

        c = country_by_number(teamleader.country_id) 
        country_team["country"] = {
            :code => c.alpha2,
            :cs_translation => c.translation(:cs),
            :en_translation => c.translation(:en)
        }

        teams = Team.where(country_id: teamleader.country_id).order('last_name DESC')

        if teams.where(individual: true).count > 0
            country_team["individual"] = Hash.new
            country_team["individual"]["small"] = teams.where(category: 'S', individual: true) 
            country_team["individual"]["medium"] = teams.where(category: 'M', individual: true)
            country_team["individual"]["large"] = teams.where(category: 'L', individual: true)
        end

        if teams.where(squads: true).count > 0
            country_team["teams"] = Hash.new
            country_team["teams"]["small"] = teams.where(category: 'S', squads: true)
            country_team["teams"]["medium"] = teams.where(category: 'M', squads: true)
            country_team["teams"]["large"] = teams.where(category: 'L', squads: true)
        end

        if teams.where(reserve: true).count > 0
            country_team["reserve"] = Hash.new
            country_team["reserve"]["small"] = teams.where(category: 'S', reserve: true)
            country_team["reserve"]["medium"] = teams.where(category: 'M', reserve: true)
            country_team["reserve"]["large"] = teams.where(category: 'L', reserve: true)
        end

        leadership = StaffMember.where(country_id: teamleader.country_id).order('role_type ASC')
        if not leadership.nil? and leadership.count
            country_team["leadership"] = leadership
        end

        country_team
    end
end
