class ConfirmationController < ApplicationController
    before_filter :authenticate_user!

    def index
        @handlers = Handler.all(:conditions => { :country_id => current_user.country_id })
    end
    
    def confirm_all
        if not current_user.confirm_all 
            users = User.all(:conditions => { :country_id => current_user.country_id })
            users.each do |user|
                user.confirm_all = true
                user.save
            end
            generate_payment_information_for_country(current_user.country_id)
            send_confirmation_mail
            flash[:notice] = t('confirmation.controller.successfully_confirmed_all_entries')
        else 
            flash[:notice] = t('confirmation.controller.already_confirmed_all_entries')
        end
        redirect_to "/confirmation/payment_information"
    end

    def payment_information
        @payment = Payment.find_by_country_id(current_user.country_id)
    end

    private
    def generate_payment_information_for_country(country_id)
        small, medium, large = 0, 0, 0
        handlers = Handler.all(:conditions => { :country_id => current_user.country_id })
        handlers.each do |handler|
            handler.dogs.collect.each do |dog|
                if dog.category == "S"
                    small += 1
                elsif dog.category == "M"
                    medium += 1
                elsif dog.category == "L"
                    large += 1
                end
            end
        end
        total_teams = ((small - 1) + (medium - 1) + (large - 1))
        total_price = total_teams * 85
        if total_price < 0
            total_price = 0
        end
        @payment = Payment.create!(:country_id => country_id, :price_in_euros => total_price, :total_teams => total_teams + 3)
    end

    def send_confirmation_mail
        ConfirmationMailer.send_confirmation(current_user, @payment).deliver
    end
end
