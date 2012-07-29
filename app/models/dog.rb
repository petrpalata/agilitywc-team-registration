class Dog < ActiveRecord::Base
  attr_accessible :breed_id, :date_of_birth, :license, :microchip, :microchip_position, :nickname, :owner_address, :owner_first_name, :owner_last_name, :owner_phone_number, :record_book, :registered_name, :studbook, :studbook_number, :tatoo, :user_id
end
