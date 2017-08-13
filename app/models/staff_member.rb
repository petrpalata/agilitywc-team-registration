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

    has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120', :portrait => "250x250" }, :path => ":rails_root/public/system/:class/:attachment/:id/:style/:filename", :url => '/system/:class/:attachment/:id/:style/:filename'
    validates_attachment_presence :picture
    validates_attachment_size :picture, :less_than => 5.megabytes
    validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/png', 'image/gif']

    validate :check_maximum_count

    def check_maximum_count
        if StaffMember.where(:country_id => country_id).count > 4
            errors.add(:base, I18n.t('teams.form.maximum_staff_count'))
        end
    end

    def as_json(*a)
        lang = I18n.locale
        I18n.locale = 'cs'
        role_cs = possible_roles[role_type]

        I18n.locale = 'en'
        role_en = possible_roles[role_type]

        I18n.locale = lang
        {
            "full_name" => full_name,
            "role_cs" => role_cs,
            "role_en" => role_en,
            "picture_url" => picture.url,
            "show_role" => role_type < 4
        }
    end
end
