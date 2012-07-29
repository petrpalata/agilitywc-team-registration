class Handler < ActiveRecord::Base
  attr_accessible :country_id, :first_name, :insurance, :last_name, :user_id
end
