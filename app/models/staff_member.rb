class StaffMember < ActiveRecord::Base
    include StaffMembersHelper
    attr_accessible :full_name,
        :role_type,
        :picture,
        :number_size,
        :phone_number,
        :email,
        :country_id

    validates_presence_of :full_name,
        :role_type,
        :phone_number

    validates_presence_of :number_size, if: "role_type == 1"

    validates_format_of :number_size, :with => /XXS|XS|S|M|L|XL/
        
    validates_inclusion_of :role_type, :in => 1..5

    has_attached_file :picture, :styles => { :big_thumb => '120x120', :portrait => "150x200" }, :path => ":rails_root/public/system/:class/:attachment/:id/:style/:filename", :url => '/system/:class/:attachment/:id/:style/:filename', :convert_options => { :portrait => "-quality 75 -strip" }
    validates_attachment_presence :picture
    validates_attachment_size :picture, :less_than => 5.megabytes
    validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/png', 'image/gif']

    validate :check_maximum_count

    def check_maximum_count
        if StaffMember.where(:country_id => country_id).count > 4
            errors.add(:base, I18n.t('teams.form.maximum_staff_count'))
        end
    end

    def role_name
        possible_roles[role_type]
    end

    def as_json(*a)
        lang = I18n.locale
        I18n.locale = 'cs'
        role_cs = role_name

        I18n.locale = 'en'
        role_en = role_name

        I18n.locale = lang
        {
            "full_name" => full_name,
            "role_cs" => role_cs,
            "role_en" => role_en,
            "picture_url" => picture.url(:portrait),
            "show_role" => role_type < 5
        }
    end

    def country_text
        Country.find_country_by_number("0" * (3 - country_id.to_s.length) + country_id.to_s).name
    end

    def self.to_csv
        attributes = %w{ id country_text full_name role_name number_size phone_number email }

        CSV.generate(headers: true) do |csv|
            csv << attributes

            current_scope.each do |team|
                csv << attributes.map{ |attr| team.send(attr) }
            end
        end
    end
end
