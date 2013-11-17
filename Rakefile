require 'rake'
require 'rake/testtask'
require 'sinatra/activerecord/rake'
require 'yard'

task :environment do
  require File.expand_path('../config/boot.rb', __FILE__)
end

namespace :db do
  task :migrate => [:environment] do
    Rake::Task['db:migrate'].invoke
  end
end

desc 'Start an app console (can also just call racksh)'
task :console do |t|
  exec 'racksh'
end

desc 'Generate project API documentation with Yard'
task :yard => [:environment] do |t|
  exec "yardoc #{LOAD_PATHS.join(' ')}"
end

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end
