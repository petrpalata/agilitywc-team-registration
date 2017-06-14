class ApplicationController < ActionController::Base
    helper :all

    before_filter :set_locale

    protect_from_forgery
    rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
    end

    private 

    def set_locale
        if params[:locale]
            session[:locale] = params[:locale]
            redirect_to params.merge({:locale => nil})
            return false
        end
        if Rails.env == 'production'
            session[:locale] ||=  'en'
        else 
            session[:locale] ||=  'cs'
        end
        I18n.locale = session[:locale]
    end

end
