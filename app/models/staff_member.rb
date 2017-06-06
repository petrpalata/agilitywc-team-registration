class StaffMember < ActiveRecord::Base
    attr_accessible :full_name,
        :role_type,
        :picture,
        :number_size,
        :number_name,
        :phone_number,
        :email

    validates_presence_of :full_name,
        :role_type,
        :phone_number

    validates_presence_of :number_name, if: "role_type == 1"
    validates_presence_of :number_size, if: "role_type == 1"

        
    validates_inclusion_of :role_type, :in => 1..5

    has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120' }
    validates_attachment_presence :picture
    validates_attachment_size :picture, :maximum => 5.megabytes
end
