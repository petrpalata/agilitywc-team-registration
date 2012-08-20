class IndexController < ApplicationController
  def index
      if current_user && (current_user.admin? || current_user.superadmin?)
          @payments = Payment.all
      end
  end
end
