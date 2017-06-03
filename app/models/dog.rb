class Dog < ActiveRecord::Base
    attr_accessible :name,
        :date_of_birth,
        :microchip,
        :microchip_position,
        :owner_address,
        :owner_first_name,
        :owner_last_name,
        :owner_phone_number,
        :tatoo,
        :sex,
        :country_id
  
    validates_presence_of :name,
        :date_of_birth,
        :microchip,
        :microchip_position,
        :owner_first_name,
        :owner_last_name,
        :sex,
        :country_id

  validates_format_of :sex, :with => /M|F/
end
