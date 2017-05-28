class Team < ActiveRecord::Base
  # handler
  attr_accessible :country_id, :first_name, :insurance, :last_name, :picture
  validates_presence_of :first_name, :last_name, :country_id, :picture, :insurance

  # dog
  attr_accessible :dog_breed_id, 
      :dog_date_of_birth,
      :dog_microchip,
      :dog_microchip_position,
      :dog_nickname,
      :dog_owner_address,
      :dog_owner_first_name,
      :dog_owner_last_name,
      :dog_owner_phone_number,
      :dog_record_book_or_license,
      :dog_registered_name,
      :dog_studbook_and_number,
      :dog_tatoo,
      :category,
      :reserve,
      :dog_sex
  
  validates_presence_of :dog_registered_name,
      :dog_date_of_birth,
      :dog_microchip,
      :dog_microchip_position,
      :dog_studbook_and_number,
      :dog_record_book_or_license,
      :dog_breed_id,
      :category,
      :dog_owner_first_name,
      :dog_owner_last_name,
      :dog_sex 

  validates_format_of :dog_sex, :with => /M|F/
  validates_format_of :category, :with => /S|M|L/


  # picture
  has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120' }
  validates_attachment_presence :picture
  validates_attachment_size :picture, :maximum => 5.megabytes
end
