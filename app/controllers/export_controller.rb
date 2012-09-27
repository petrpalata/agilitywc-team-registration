class ExportController < ApplicationController
    before_filter :authenticate_user!, :superadmin_only

    def generate_random_startnumbers
        start_number = 1
        handlers = Handler.all(:include => :dogs).order("dogs.category DESC, last_name ASC")
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
        @handlers = Handler.all(:include => :dogs, :order => "dogs.start_number")
        respond_to do |format|
            format.csv {
                render :partial => "export/catalogue.csv"
            }
        end
    end


    def size_and_breed_stats
        clean_up_dogs
        @dog_breeds = Dog.select('breed_id, count(*) as count_all').group('breed_id')
        @dog_sizes = Dog.select('category, count(*) as count_all').group('category')
        respond_to do |format|
            format.csv {
                render :partial => "export/size_and_breed_stats.csv"
            }
        end
    end

    def generate_squad_numbers
        small_teams = TeamParticipation.where(:small => true)
        medium_teams = TeamParticipation.where(:medium => true)
        large_teams = TeamParticipation.where(:large => true)

        small_count = small_teams.count
        medium_count = medium_teams.count
        large_count = large_teams.count

        small_numbers = (1..small_count).to_a.shuffle
        medium_numbers = (1..medium_count).to_a.shuffle
        large_numbers = (1..large_count).to_a.shuffle

        small_numbers.zip(small_teams).each do |number, squad|
            squad.small_order = number
            squad.save
        end

        medium_numbers.zip(medium_teams).each do |number, squad|
            squad.medium_order = number
            squad.save
        end

        large_numbers.zip(large_teams).each do |number, squad|
            squad.large_order = number
            squad.save
        end

        redirect_to root_url
    end

    def squads
        @small = TeamParticipation.where(:small => true).order('small_order ASC')
        @medium = TeamParticipation.where(:medium => true).order('medium_order ASC')
        @large = TeamParticipation.where(:large => true).order('large_order ASC')
        respond_to do |format|
            format.csv {
                render :partial => "export/squads.csv"
            }
        end
    end

    def for_main_judge
        @handlers = Handler.all(:include => :dogs, :order => "dogs.start_number")
        respond_to do |format|
            format.csv {
                render :partial => "export/catalogue_for_main_judge.csv"
            }
        end
    end

private 
    def clean_up_dogs
        dogs = Dog.all
        dogs.each do |dog|
            unless Handler.find_by_id(dog.handler_id)
                dog.destroy()
            end
        end
    end

    def superadmin_only
        unless current_user.superadmin? 
            redirect_to root_url
        end
    end
end
