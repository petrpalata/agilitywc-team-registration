class TeamsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_confirmed, :only => [:new, :create, :edit, :update, :destroy]
    authorize_resource :handler, :dog
    
    # GET /teams
    # GET /teams.json
    def index
        if current_user.admin? || current_user.superadmin?
            @handlers = Handler.all
            @countries = {}
            @handlers.each do |h|
                country_name = Country.find_country_by_number("0" * (3 - h.country_id.to_s.length) + h.country_id.to_s).name
                @countries[country_name] ||= []
                @countries[country_name] << h
            end
        elsif 
            @handlers = Handler.all(:conditions => { :country_id => current_user.country_id })
        end
        @handlers.each do |h|
            authorize! :read, h
        end
    end

    # GET /teams/1
    # GET /teams/1.json
    def show
        @handler = Handler.find(params[:id])
        check_users_country
        authorize! :read, @handler
    end

    # GET /teams/new
    # GET /teams/new.json
    def new
        @handler = Handler.new
        dogs = @handler.dogs.build
        authorize! :create, @handler
    end

    # GET /teams/1/edit
    def edit
        @handler = Handler.find(params[:id])
        check_users_country
        authorize! :update, @handler
    end

    # POST /teams
    # POST /teams.json
    def create
        @handler = Handler.new(params[:handler])
        @handler.country_id = current_user.country_id
        authorize! :create, @handler
        if @handler.save
            redirect_to handlers_path, :notice => t('teams.controller.successfully_created')
        else
            render :action => 'new'
        end
    end

    # PUT /teams/1
    # PUT /teams/1.json
    def update
        @handler = Handler.find(params[:id])
        if not check_users_country
            return
        end
        if not current_user.superadmin?
            @handler.country_id = current_user.country_id
        end
        if @handler.update_attributes(params[:handler])
            redirect_to handlers_path, :notice => t('teams.controller.successfully_updated')
        else
            render :action => 'new'
        end
        authorize! :update, @handler
    end

    # DELETE /teams/1
    # DELETE /teams/1.json
    def destroy
        @handler = Handler.find(params[:id])
        authorize! :destroy, @handler
        if not check_users_country
            return
        end
        @handler.destroy
        redirect_to handlers_path, :notice => t('teams.controller.successfully_deleted')
    end

    private
        def check_users_country
            if current_user.admin? || current_user.superadmin?
                return true
            end
            if @handler.country_id != current_user.country_id
                redirect_to handlers_path, :notice => t('teams.controller.dont_have_permission')
                return false
            end
            return true
        end

        def check_if_confirmed
            if Payment.find_by_country_id(current_user.country_id)
                flash[:error] = t('teams.controller.no_changed_allowed')
                redirect_to handlers_path
            end
        end
end
