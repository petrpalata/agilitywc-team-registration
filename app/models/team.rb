class Team < ActiveRecord::Base
  # handler
  attr_accessible :country_id, :first_name, :insurance, :last_name, :picture, :number_size, :number_name, :individual, :individual_reserve, :squads, :squads_reserve, :handler_date_of_birth
  validates_presence_of :first_name, :last_name, :country_id, :picture, :insurance, :number_size, :number_name, :handler_date_of_birth

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
  validates_format_of :number_size, :with => /S|M|L|XL|XXL/

  validate :must_have_at_least_one_checked


  # picture
  has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120' }
  validates_attachment_presence :picture
  validates_attachment_size :picture, :maximum => 5.megabytes

  def must_have_at_least_one_checked
      unless individual || individual_reserve || squads || squads_reserve
          errors.add(:base, I18n.t('teams.form.at_least_one_checked'))
      end
  end
end
