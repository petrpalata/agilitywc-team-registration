class StaffMembersController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_confirmed, :only => [:new, :create, :edit, :update, :destroy]
    authorize_resource :staff_member
    
    # GET /staff_members
    # GET /staff_members.json
    def index
        if current_user.admin? || current_user.superadmin?
            @staff_members = StaffMember.all
            @countries = {}
            @staff_members.each do |t|
                country_name = Country.find_country_by_number("0" * (3 - t.country_id.to_s.length) + t.country_id.to_s).name
                @countries[country_name] ||= []
                @countries[country_name] << h
            end
        elsif 
            @staff_members = StaffMember.all(:conditions => { :country_id => current_user.country_id })
        end
        @staff_members.each do |t|
            authorize! :read, t
        end
    end

    # GET /staff_members/1
    # GET /staff_members/1.json
    def show
        @staff_member = StaffMember.find(params[:id])
        check_users_country
        authorize! :read, @staff_member
    end

    # GET /staff_members/new
    # GET /staff_members/new.json
    def new
        @staff_member = StaffMember.new
        authorize! :create, @staff_member
    end

    # GET /staff_members/1/edit
    def edit
        @staff_member = StaffMember.find(params[:id])
        check_users_country
        authorize! :update, @staff_member
    end

    # POST /staff_members
    # POST /staff_members.json
    def create
        @staff_member = StaffMember.new(params[:staff_member])
        if not current_user.superadmin?
            @staff_member.country_id = current_user.country_id
        else 
            @staff_member.country_id = Country[params[:staff_member][:country_id]].number
        end
        authorize! :create, @staff_member
        if @staff_member.save
            redirect_to staff_members_path, :notice => t('staff_members.controller.successfully_created')
        else
            render :action => 'new'
        end
    end

    # PUT /staff_members/1
    # PUT /staff_members/1.json
    def update
        @staff_member = StaffMember.find(params[:id])
        if not check_users_country
            return
        end
        country_id = @staff_member.country_id
        if @staff_member.update_attributes(params[:staff_member])
            @staff_member.country_id = country_id
            @staff_member.save
            redirect_to staff_members_path, :notice => t('staff_members.controller.successfully_updated')
        else
            render :action => 'new'
        end
        authorize! :update, @staff_member
    end

    # DELETE /staff_members/1
    # DELETE /staff_members/1.json
    def destroy
        @staff_member = StaffMember.find(params[:id])
        authorize! :destroy, @staff_member
        if not check_users_country
            return
        end
        @staff_member.destroy
        redirect_to staff_members_path, :notice => t('staff_members.controller.successfully_deleted')
    end

    private
        def check_users_country
            if current_user.admin? || current_user.superadmin?
                return true
            end
            if @staff_member.country_id != current_user.country_id
                redirect_to staff_members_path, :notice => t('staff_members.controller.dont_have_permission')
                return false
            end
            return true
        end

        def check_if_confirmed
            if Payment.find_by_country_id(current_user.country_id)
                flash[:error] = t('staff_members.controller.no_changed_allowed')
                redirect_to staff_members_path
            end
        end
end
