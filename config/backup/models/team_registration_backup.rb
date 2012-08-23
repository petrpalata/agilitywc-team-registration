# encoding: utf-8

##
# Backup Generated: team_registration_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t team_registration_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:team_registration_backup, 'Description for team_registration_backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 20

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = "team_registration_production"
    db.username           = "team_registration"
    db.password           = "chorgoj"
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/var/run/postgresql"
    db.skip_tables        = []
    db.only_tables        = []
    db.additional_options = ["-xc", "-E=utf8"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    # db.pg_dump_utility = "/opt/local/bin/pg_dump"
  end

  archive :handler_pictures do |archive|
      archive.add '/webapps/team_registration/current/public/system/pictures/'
  end

  ##
  # Dropbox File Hosting Service [Storage]
  #
  # Access Type:
  #
  #  - :app_folder (Default)
  #  - :dropbox
  #
  # Note:
  #
  #  Initial backup must be performed manually to authorize
  #  this machine with your Dropbox account.
  #
  store_with Dropbox do |db|
    db.api_key     = "qv97nkaz5ennge4"
    db.api_secret  = "hzoi65q1sh0h5cs"
    db.access_type = :app_folder
    db.path        = "/backups"
    db.keep        = 2
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

end
