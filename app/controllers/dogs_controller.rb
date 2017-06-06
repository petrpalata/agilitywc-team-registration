class DogsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_if_confirmed, :only => [:new, :create, :edit, :update, :destroy]
  authorize_resource :dog

  def index
      if current_user.admin? || current_user.superadmin?
          @dogs = Dog.all
          @countries = {}
          @dogs.each do |t|
              country_name = Country.find_country_by_number("0" * (3 - t.country_id.to_s.length) + t.country_id.to_s).name
              @countries[country_name] ||= []
              @countries[country_name] << h
          end
      elsif 
          @dogs = Dog.all(:conditions => { :country_id => current_user.country_id })
      end
      @dogs.each do |t|
          authorize! :read, t
      end
  end

  def show
    @dog = Dog.find(params[:id])
    check_users_country
    authorize! :read, @dog
  end

  def new
    @dog = Dog.new
    authorize! :create, @dog
  end

  def edit
    @dog = Dog.find(params[:id])
    check_users_country
    authorize! :update, @dog
  end

  def create
      @dog = Dog.new(params[:dog])
      if not current_user.superadmin?
          @dog.country_id = current_user.country_id
      else 
          @dog.country_id = Country[params[:dog][:country_id]].number
      end
      authorize! :create, @dog
      if @dog.save
          redirect_to dogs_path, :notice => t('dogs.controller.successfully_created')
      else
          render :action => 'new'
      end
  end

  def update
      @dog = Dog.find(params[:id])
      check_users_country
      country_id = @dog.country_id
      if @dog.update_attributes(params[:dog])
          @dog.country_id = country_id
          @dog.save
          redirect_to dogs_path, :notice => t('dogs.controller.successfully_updated')
      else
          render :action => 'edit'
      end
      authorize! :update, @dog
  end

  def destroy
      @dog = Dog.find(params[:id])
      authorize! :destroy, @dog
      check_users_country
      @dog.destroy
      redirect_to dogs_path, :notice => t('dogs.controller.successfully_deleted')
  end

    private
        def check_users_country
            unless current_user.admin? || current_user.superadmin? || @dog.country_id == current_user.country_id
                redirect_to action: :index, :notice => t('dogs.controller.dont_have_permission') 
                yield
            end
        end

        def check_if_confirmed
            if Payment.find_by_country_id(current_user.country_id)
                flash[:error] = t('dogs.controller.no_changed_allowed')
                redirect_to dogs_path
            end
        end
end
