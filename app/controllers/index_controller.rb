class IndexController < ApplicationController
  def index
      if current_user && (current_user.admin? || current_user.superadmin?)
          @payments = Payment.all
      end
  end

  def all_handlers
      I18n.locale = params[:language]
      country = Country[params[:country_id].upcase]
      if country
          @handlers = Handler.where(:country_id => country.number.to_i).all
          @country_name = country.name
      else 
          @handlers = []
          @country_name = ""
      end
      respond_to do |format|
          format.html {
              render :partial => "index/all_handlers.html"
          }
      end
  end
end
