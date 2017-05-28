class ConfirmationController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_admin_or_superadmin

    def index
        @handlers = Team.where(:country_id => current_user.country_id).all
    end
    
    def confirm_all
        if not current_user.confirm_all 
            users = User.where(:country_id => current_user.country_id).all
            users.each do |user|
                user.confirm_all = true
                user.save
            end
            generate_payment_information_for_country(current_user.country_id)

            participation = TeamParticipation.find_by_country_id(current_user.country_id)
            unless participation
                TeamParticipation.create(
                    :country_id => current_user.country_id,
                    :small => params[:small],
                    :medium => params[:medium],
                    :large => params[:large]
                )
            else 
                participation.small = params[:small]
                participation.medium = params[:medium]
                participation.large = params[:large]
                participation.save
            end
            send_confirmation_mail
            flash[:notice] = t('confirmation.controller.successfully_confirmed_all_entries')
        else 
            flash[:notice] = t('confirmation.controller.already_confirmed_all_entries')
        end
        redirect_to confirmation_payment_information_path
    end

    def payment_information
        @payment = Payment.find_by_country_id(current_user.country_id)
        if @payment.nil? 
            redirect_to handlers_path
        end
    end

    private
    def generate_payment_information_for_country(country_id)
        total_teams = 0
        reserves = {
            'S' => 0,
            'M' => 0, 
            'L' => 0
        }
        handlers = Team.where(:country_id => current_user.country_id).all
        handlers.each do |handler|
            handler.dogs.collect.each do |dog|
                if dog.reserve 
                    reserves[dog.category] += 1
                end
                total_teams += 1
            end
        end
        total_reserves = 0
        total_reserves += 1 if reserves['S'] > 0 
        total_reserves += 1 if reserves['M'] > 0 
        total_reserves += 1 if reserves['L'] > 0 

        total_price = (total_teams * 85) - (total_reserves * 85)
        @payment = Payment.create!(:country_id => country_id, :price_in_euros => total_price, :total_teams => total_teams)
    end

    def send_confirmation_mail
        ConfirmationMailer.send_confirmation_mail(current_user, @payment).deliver
    end

    def check_admin_or_superadmin
        if current_user.admin? || current_user.superadmin?
            redirect_to handlers_path
        end
    end
end
