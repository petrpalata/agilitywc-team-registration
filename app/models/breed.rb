class Breed < ActiveRecord::Base
  attr_accessible :fci_number, :name
  has_and_belongs_to_many :dogs
end
