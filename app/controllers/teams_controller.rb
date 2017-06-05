class TeamsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_confirmed, :only => [:new, :create, :edit, :update, :destroy]
    authorize_resource :team
    
    # GET /teams
    # GET /teams.json
    def index
        if current_user.admin? || current_user.superadmin?
            @teams = Team.all
            @countries = {}
            @teams.each do |t|
                country_name = Country.find_country_by_number("0" * (3 - t.country_id.to_s.length) + t.country_id.to_s).name
                @countries[country_name] ||= []
                @countries[country_name] << h
            end
        elsif 
            @teams = Team.all(:conditions => { :country_id => current_user.country_id })
        end
        @teams.each do |t|
            authorize! :read, t
        end
    end

    # GET /teams/1
    # GET /teams/1.json
    def show
        @team = Team.find(params[:id])
        check_users_country
        authorize! :read, @team
    end

    # GET /teams/new
    # GET /teams/new.json
    def new
        @team = Team.new
        authorize! :create, @team
    end

    # GET /teams/1/edit
    def edit
        @team = Team.find(params[:id])
        check_users_country
        authorize! :update, @team
    end

    # POST /teams
    # POST /teams.json
    def create
        @team = Team.new(params[:team])
        if not current_user.superadmin?
            @team.country_id = current_user.country_id
        else 
            @team.country_id = Country[params[:team][:country_id]].number
        end
        authorize! :create, @team
        if @team.save
            redirect_to teams_path, :notice => t('teams.controller.successfully_created')
        else
            render :action => 'new'
        end
    end

    # PUT /teams/1
    # PUT /teams/1.json
    def update
        @team = Team.find(params[:id])
        if not check_users_country
            return
        end
        country_id = @team.country_id
        if @team.update_attributes(params[:team])
            @team.country_id = country_id
            @team.save
            redirect_to teams_path, :notice => t('teams.controller.successfully_updated')
        else
            render :action => 'new'
        end
        authorize! :update, @team
    end

    # DELETE /teams/1
    # DELETE /teams/1.json
    def destroy
        @team = Team.find(params[:id])
        authorize! :destroy, @team
        if not check_users_country
            return
        end
        @team.destroy
        redirect_to teams_path, :notice => t('teams.controller.successfully_deleted')
    end

    private
        def check_users_country
            if current_user.admin? || current_user.superadmin?
                return true
            end
            if @team.country_id != current_user.country_id
                redirect_to teams_path, :notice => t('teams.controller.dont_have_permission')
                return false
            end
            return true
        end

        def check_if_confirmed
            if Payment.find_by_country_id(current_user.country_id)
                flash[:error] = t('teams.controller.no_changed_allowed')
                redirect_to teams_path
            end
        end
end
