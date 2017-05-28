class MoveDogInformationToTeam < ActiveRecord::Migration
    def change
        change_table :teams do |t|
            t.string   "dog_nickname"
            t.string   "dog_registered_name"
            t.integer  "dog_breed_id"
            t.date     "dog_date_of_birth"
            t.string   "dog_studbook_and_number"
            t.string   "dog_record_book_or_license"
            t.string   "dog_tatoo"
            t.string   "dog_microchip"
            t.string   "dog_microchip_position"
            t.string   "dog_owner_first_name"
            t.string   "dog_owner_last_name"
            t.text     "dog_owner_address"
            t.string   "dog_owner_phone_number"
            t.string   "category"
            t.boolean  "reserve",                :default => false
            t.string   "dog_sex"
            t.integer  "start_number"
        end
    end
end
