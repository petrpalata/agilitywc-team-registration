class ExportController < ApplicationController
    before_filter :authenticate_user!

    def generate_random_startnumbers
        if !current_user.superadmin? 
            redirect_to root_url
            return
        end
        start_number = 1
        handlers = Handler.order("last_name ASC")
        handlers.each do |handler|
            handler.dogs.all.each do |dog|
                dog.start_number = start_number
                start_number += 1
                dog.save
            end
        end
        redirect_to root_url
    end

    def catalogue
        if !current_user.superadmin? 
            redirect_to root_url
            return
        end
        @handlers = Handler.all(:include => :dogs, :order => "dogs.start_number")
        respond_to do |format|
            format.csv {
                render :partial => "export/catalogue.csv"
            }
        end
    end
end
