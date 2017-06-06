class ConfirmationController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_admin_or_superadmin

    def index
    end
    
    def confirm_all
        if not current_user.confirm_all 
            users = User.where(:country_id => current_user.country_id)
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
            redirect_to teams_path
        end
    end

    private
    def generate_payment_information_for_country(country_id)
        total_teams = Team.where(:country_id => current_user.country_id, :reserve => false).count

        staff_members_to_pay = StaffMember.where(:country_id => current_user.country_id).count - 2
        if staff_members_to_pay < 0
            staff_members_to_pay = 0
        end
        total_price = total_teams * 90 + staff_members_to_pay * 60

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
