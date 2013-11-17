$:.unshift File.expand_path('../../', __FILE__)

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'
require 'database_cleaner'

require 'config/boot'
require 'test/factory'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.start

module MiniTestDbCleaner
  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    super
  end
end

class MiniTest::Unit::Testcase; include MiniTestDbCleaner; end;
