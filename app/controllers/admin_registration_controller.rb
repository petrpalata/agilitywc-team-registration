class AdminRegistrationController < Devise::RegistrationsController
    before_filter :authenticate_super_admin!
    authorize_resource Admin

    def new
        @admin = Admin.new
    end

    def create
        params[:admin][:password] = Devise.friendly_token[0,15]
        super
    end
end
