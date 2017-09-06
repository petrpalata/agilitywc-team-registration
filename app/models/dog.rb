class Dog < ActiveRecord::Base
    def self.microchip_positions
        {
            "RN" => I18n.t('activerecord.attributes.dog.microchip_positions.right_side_of_neck'),
            "LN" => I18n.t('activerecord.attributes.dog.microchip_positions.left_side_of_neck'),
            "O" => I18n.t('activerecord.attributes.dog.microchip_positions.other'),
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

  def country_text
      Country.find_country_by_number("0" * (3 - country_id.to_s.length) + country_id.to_s).name
  end

  def self.to_csv
      attributes = %w{ country_text name date_of_birth tatoo sex microchip microchip_position owner_address owner_first_name owner_last_name owner_phone_number }

      CSV.generate(headers: true) do |csv|
          csv << attributes

          current_scope.each do |team|
              csv << attributes.map{ |attr| team.send(attr) }
          end
      end
  end
end
