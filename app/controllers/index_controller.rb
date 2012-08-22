class IndexController < ApplicationController
  def index
      if current_user && (current_user.admin? || current_user.superadmin?)
          @payments = Payment.all
      end
  end

  def all_handlers
      I18n.locale = params[:language]
      @handlers = Handler.where(:country_id => Country[params[:country_id].upcase].number.to_i).all
      @country_name = Country[params[:country_id].upcase].name
      respond_to do |format|
          format.html {
              render :partial => "index/all_handlers.html"
          }
      end
  end
end
