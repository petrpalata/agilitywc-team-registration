class StaffMember < ActiveRecord::Base
    attr_accessible :full_name,
        :role_type,
        :picture

    validates_presence_of :full_name,
        :role_type
        
    validates_inclusion_of :role_type, :in => 1..5

    has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120' }
    validates_attachment_presence :picture
    validates_attachment_size :picture, :maximum => 5.megabytes
end
