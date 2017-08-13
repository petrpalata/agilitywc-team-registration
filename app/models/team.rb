class Team < ActiveRecord::Base
  # handler
  attr_accessible :country_id, :first_name, :insurance, :last_name, :picture, :number_size, :individual, :squads, :reserve, :handler_date_of_birth, :pedigree
  validates_presence_of :first_name, :last_name, :country_id, :number_size, :handler_date_of_birth

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
  validates_format_of :number_size, :with => /XXS|XS|S|M|L|XL/

  validate :either_competing_or_reserve
  validate :check_maximum_count


  # picture
  has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120' }, :path => ":rails_root/public/system/:class/:attachment/:id/:style/:filename", :url => '/system/:class/:attachment/:id/:style/:filename'

  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :pedigree, :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/aws.yml",
      :s3_permissions => :private,
      :path => "pedigree/:id/:id_:dog_registered_name_:last_name.:extension",
      :s3_host_name => "s3-eu-west-2.amazonaws.com",
      :bucket => "teamleaders.agility2017.cz"

  validates_attachment_presence :pedigree
  validates_attachment_size :pedigree, :less_than => 20.megabytes
  validates_attachment_content_type :pedigree, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']

  validates_inclusion_of :dog_microchip_position, in: Dog.microchip_positions.keys

  Paperclip.interpolates :dog_registered_name do |attachment, style|
      attachment.instance.dog_registered_name.parameterize
  end

  Paperclip.interpolates :last_name do |attachment, style|
      attachment.instance.last_name.parameterize
  end


  def either_competing_or_reserve
      if ((individual || squads) && reserve) || !(individual || squads || reserve)
          errors.add(:individual)
          errors.add(:squads)
          errors.add(:reserve)
          errors.add(:base, I18n.t('teams.form.either_competing_or_reserve'))
      end
  end

  def check_maximum_count
      if Team.where(:country_id => country_id, :category => category, :reserve => true).count > 0 && reserve
          errors.add(:base, I18n.t('teams.form.maximum_reserve_count'))
      end
  end

  def as_json(*a)
      {
          "full_name" => "#{first_name.strip} #{last_name.strip}",
          "dog" => "#{dog_registered_name.strip} (#{dog_nickname.strip})",
          "breed" => Breed.find(dog_breed_id).name,
          "picture_url" => picture.url(:big_thumb)
      }
  end

end
