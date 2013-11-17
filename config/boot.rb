ENV['RACK_ENV'] ||= 'development'

$:.unshift File.expand_path('../../', __FILE__)

require 'bundler/setup'

Bundler.require

LOAD_PATHS = %w{
  lib/**/*.rb
  app/models/**/*.rb
  app/helpers/*_helper.rb
  config/initializers/*.rb
  config/*.rb
  app/controllers/application_controller.rb
  app/controllers/*_controller.rb
}

LOAD_PATHS.each do |path|
  Dir.glob(path).each do |file|
    require file
  end
end
