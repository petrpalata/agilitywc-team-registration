class Dog < ActiveRecord::Base
  attr_accessible :breed_id, :date_of_birth, :license, :microchip, :microchip_position, :nickname, :owner_address, :owner_first_name, :owner_last_name, :owner_phone_number, :record_book, :registered_name, :studbook, :studbook_number, :tatoo, :user_id, :handler_id, :category
  
  validates_presence_of :registered_name, :date_of_birth, :microchip, :microchip_position, :owner_address, :owner_first_name, :owner_last_name, :studbook, :record_book, :breed_id, :studbook_number, :category
  validates_length_of :category, :minimum => 1, :maximum => 1
  validates_numericality_of :studbook_number, :microchip, :tatoo
end
