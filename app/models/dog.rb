class Dog < ActiveRecord::Base
    def self.microchip_positions
        {
            "RN" => I18n.t('dog.model.right_side_of_neck'),
            "LN" => I18n.t('dog.model.left_side_of_neck'),
            "O" => I18n.t('dog.model.other'),
        }
    end

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
        :owner_first_name,
        :owner_last_name,
        :sex,
        :country_id

  validates_format_of :sex, :with => /M|F/
  validates_inclusion_of :microchip_position, in: Dog.microchip_positions.keys
end
