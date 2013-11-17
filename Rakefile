require 'rake'
require 'rake/testtask'
require 'sinatra/activerecord/rake'
require 'yard'

ENV['RACK_ENV'] ||= 'development'

task :environment do
  require File.expand_path '../config/boot.rb', __FILE__
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

desc 'Start an app server'
task :server do |t|
  exec "RACK_ENV=#{ENV['RACK_ENV']} rackup"
end

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

namespace :generate do
  task :model => [:environment] do
    unless ENV['NAME']
      puts 'Please provide the model name with NAME=' 
      return
    end
    name = ENV['NAME'].dup
    puts "Generating a migration for #{name}"
    ENV['NAME'] = "create_#{name.underscore}"
    Rake::Task['db:create_migration'].invoke
    ENV['NAME'] = name
    generate_model name
  end

  task :resource => [:environment, 'generate:model'] do
    generate_resource ENV['NAME']
  end

  def generate_resource(name)
    rsrc_name = name.camelize
    rsrc_template = <<-TPL.gsub(/^ {6}/, '')
      module Controllers
        class #{rsrc_name}Controller < ApplicationController
          # @!method get_index
          # @overload get '/'
          # Gets a paginated list of JSON-encoded{#{rsrc_name}}s
          get '/' do
            json #{rsrc_name}.page(params['page']).per(params['per'])
          end

          # @!method get_show
          # @overload get '/:id'
          # Gets a JSON-encoded {#{rsrc_name}} by id
          get '/:id' do
            json #{rsrc_name}.find params[:id]
          end

          # @!method post_create
          # @overload post '/'
          # Creates a new {#{rsrc_name}} from the data in the request body
          post '/' do
            data = JSON.parse request.body.read.to_s
            #{name} = #{rsrc_name}.new data
            #{name}.save
            json #{name}
          end

          # @!method put_update
          # @overload put '/:id'
          # Updates a {#{rsrc_name}} by id
          put '/:id' do
            #{name} = #{rsrc_name}.find params[:id]
            data = JSON.parse request.body.read.to_s
            #{name}.update_attributes data
            json #{name}
          end

          # @!method delete_destroy
          # @overload delete '/:id'
          # Deletes a {#{rsrc_name}} by id
          delete '/:id' do
            json #{rsrc_name}.find(params[:id]).destroy
          end
        end
      end
    TPL
    rsrc_file = "#{File.expand_path('../app/controllers', __FILE__)}/#{name.pluralize.underscore}_controller.rb"
    puts "Generating controller scaffold for #{name} model at #{rsrc_file}"
    File.open(rsrc_file, 'w') { |f| f.write rsrc_template }
  end

  def generate_model(name)
    cls_template = <<-TPL.gsub(/^ {6}/, '')
      class #{name.camelize} < ActiveRecord::Base
        # @!attribute id
        #   @return [Integer] The primary key of the {#{name.camelize}}
      end
    TPL
    cls_file = "#{File.expand_path('../app/models', __FILE__)}/#{name.underscore}.rb"
    puts "Generating empty #{name} model at #{cls_file}"
    File.open(cls_file, 'w') { |f| f.write cls_template }
  end
end
