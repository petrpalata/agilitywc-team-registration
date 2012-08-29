class Handler < ActiveRecord::Base
  attr_accessible :country_id, :first_name, :insurance, :last_name, :dogs_attributes, :picture
  validates_presence_of :first_name, :last_name, :dogs, :country_id, :picture, :insurance
  has_many :dogs
  has_attached_file :picture, :styles => { :thumbnail => '50x80', :big_thumb => '120x120' }
  validates_attachment_presence :picture
  validates_attachment_size :picture, :maximum => 5.megabytes

  accepts_nested_attributes_for :dogs, :allow_destroy => true
end
