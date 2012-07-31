class Handler < ActiveRecord::Base
  attr_accessible :country_id, :first_name, :insurance_company, :insurance_contract_number, :last_name, :dogs_attributes, :picture
  validates_presence_of :first_name, :last_name, :dogs, :country_id, :picture
  has_many :dogs
  has_attached_file :picture
  validates_attachment_presence :picture
  validates_attachment_size :picture, :maximum => 5.megabytes

  accepts_nested_attributes_for :dogs, :allow_destroy => true
end
