# encoding: utf-8

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
          @handlers = Team.where(:country_id => country.number.to_i).all
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
  
  def confirm_payment
      if current_user && (current_user.admin? || current_user.superadmin?)
          payment = Payment.find(params[:id])
          payment.confirmed = true
          payment.save
          redirect_to root_url, :notice => "Platba potvrzena."
      else 
          redirect_to root_url, :notice => "You are not authorized for this operation."
      end
  end

  def delete_payment
      if current_user && (current_user.admin? || current_user.superadmin?)
          payment = Payment.find(params[:id])
          if payment.confirmed
              redirect_to root_url, :notice => "Potvrzené platby nelze smazat."
              return
          end
          users = User.where(:country_id => payment.country_id).all
          users.each do |user|
              user.confirm_all = false
              user.save
          end
          payment.destroy
          redirect_to root_url, :notice => "Platba úspěšně smazána."
      else 
          redirect_to root_url, :notice => "You are not authorized for this operation."
      end
  end

  def numbers_information
  end
end
