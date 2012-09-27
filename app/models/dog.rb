class Dog < ActiveRecord::Base
    belongs_to :handler
  attr_accessible :breed_id, :date_of_birth, :microchip, :microchip_position, :nickname, :owner_address, :owner_first_name, :owner_last_name, :owner_phone_number, :record_book_or_license, :registered_name, :studbook_and_number, :tatoo, :user_id, :handler_id, :category, :reserve, :sex
  
  validates_presence_of :registered_name, :date_of_birth, :microchip, :microchip_position, :studbook_and_number, :record_book_or_license, :breed_id, :category, :owner_first_name, :owner_last_name, :sex 
  validates_format_of :sex, :with => /M|F/
  validates_format_of :category, :with => /S|M|L/
end
