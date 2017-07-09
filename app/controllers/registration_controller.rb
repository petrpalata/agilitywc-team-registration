# encoding: UTF-8

class RegistrationController < DeviseController
    before_filter :authenticate_user!
    load_and_authorize_resource :class => "User"

    def index
        if current_user.admin? || current_user.superadmin? 
            @users = User.where(:role_cd => 2)
        else 
            redirect_to root_url, :notice => "Nemáte dostatečná oprávnění"
        end
    end

    def new
        @user = User.new
    end

    def create
        params[:user][:password] = Devise.friendly_token[0,12]
        country_id = Country[params[:user][:country_id]].number
        params[:user][:country_id] = country_id
        users_by_country = User.where(:country_id => country_id, :confirm_all => true).all
        payments = Payment.where(:country_id => country_id).all

        @user = User.new(params[:user])
        if users_by_country.count > 0 || payments.count > 0
            @user.confirm_all = true
        end

        if current_user.superadmin?
            @user.role = :admin
        else
            @user.role = :user
        end

        if @user.save
            redirect_to new_user_registration_path, :notice => t('registration.controller.successfully_created_new_user')
        else
            clean_up_passwords @user
            render :new
        end
    end

    def destroy
        user = User.find(params[:id])
        if (current_user.admin? || current_user.superadmin?) && user.role_cd == 2
            user.destroy
            redirect_to list_users_path, :notice => "Uživatel byl úspěšně odstraněn"
        else 
            redirect_to root_url, :notice => "Nemáte dostatečná oprávnění"
        end
    end

    def resend_email
        user = User.find(params[:id])
        if (current_user.admin? || current_user.superadmin?) && user.role_cd == 2
            user.update_password(Devise.friendly_token[0, 12])
            user.save
            redirect_to list_users_path, :notice => "E-mail odeslán"
        else 
            redirect_to root_url, :notice => "Nemáte dostatečná oprávnění"
        end
    end

    def switch_show_country
        if current_user.superadmin?
            user = User.find(params[:id])
            user.show_country = !user.show_country
            user.save
            redirect_to list_users_path, :notice => "Přehozeno"
        else 
            redirect_to root_url, :notice => "Nemáte dostatečná oprávnění"
        end
    end
end
