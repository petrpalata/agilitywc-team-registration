class RegistrationController < DeviseController
    before_filter :authenticate_user!
    load_and_authorize_resource :class => "User"

    def new
        @user = User.new
    end

    def create
        params[:user][:password] = Devise.friendly_token[0,12]
        params[:user][:country_id] = Country[params[:user][:country_id]].number
        @user = User.new(params[:user])

        if current_user.superadmin?
            @user.role = :admin
        else
            @user.role = :user
        end

        if @user.save
            redirect_to root_url, :notice => t('registration.controller.successfully_created_new_user')
        else
            clean_up_passwords @user
            render :new
        end
    end
end
