class TeamsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_confirmed, :only => [:new, :create, :edit, :update, :destroy]
    load_and_authorize_resource :handler, :dog
    
    # GET /teams
    # GET /teams.json
    def index
        @handlers = Handler.all(:conditions => { :country_id => current_user.country_id })
    end

    # GET /teams/1
    # GET /teams/1.json
    def show
        @handler = Handler.find(params[:id])
        check_users_country
    end

    # GET /teams/new
    # GET /teams/new.json
    def new
        @handler = Handler.new
        dogs = @handler.dogs.build
    end

    # GET /teams/1/edit
    def edit
        @handler = Handler.find(params[:id])
        check_users_country
    end

    # POST /teams
    # POST /teams.json
    def create
        @handler = Handler.new(params[:handler])
        @handler.country_id = current_user.country_id
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
        check_users_country
        @handler.country_id = current_user.country_id
        if @handler.update_attributes(params[:handler])
            redirect_to handlers_path, :notice => t('teams.controller.successfully_updated')
        else
            render :action => 'new'
        end
    end

    # DELETE /teams/1
    # DELETE /teams/1.json
    def destroy
        @handler = Handler.find(params[:id])
        check_users_country
        @handler.destroy
        redirect_to handlers_path, :notice => t('teams.controller.successfully_deleted')
    end

    private
        def check_users_country
            if @handler.country_id != current_user.country_id
                redirect_to handlers_path, :notice => t('teams.controller.dont_have_permission')
            end
        end

        def check_if_confirmed
            if Payment.find_by_country_id(current_user.country_id)
                flash[:error] = t('teams.controller.no_changed_allowed')
                redirect_to handlers_path
            end
        end
end
