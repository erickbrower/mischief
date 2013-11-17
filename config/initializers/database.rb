module Initializers
  module Database

    def self.included(base)
      base.class_eval do

        configure :production, :development, :test do |env|
          ActiveRecord::Base.establish_connection(
            host:     settings.db['host'],
            adapter:  settings.db['adapter'],
            database: settings.db['database'],
            username: settings.db['username'],
            password: settings.db['password'],
            encoding: 'utf8'
          )
        end

        configure :development, :test do |env|
          ActiveRecord::Base.logger = Logger.new($stdout)
        end

      end
    end
  end
end
