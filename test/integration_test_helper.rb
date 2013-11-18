require File.expand_path '../test_helper.rb', __FILE__
INTEGRATION_APP = Rack::Builder.parse_file(File.expand_path('../../config.ru', __FILE__)).first
