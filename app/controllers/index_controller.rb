class IndexController < ApplicationController
  def index
      if current_user && (current_user.admin? || current_user.superadmin?)
          @payments = Payment.all
      end
  end

  def all_handlers
      @handlers = Handler.all
      respond_to do |format|
          format.html {
              render :partial => "index/all_handlers.html"
          }
      end
  end
end
