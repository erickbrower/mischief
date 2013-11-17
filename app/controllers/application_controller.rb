module Controllers
  class ApplicationController < Sinatra::Base
    # @!method register_sinatra_active_record_extension
    # @overload register Sinatra::ActiveRecordExtension
    # Registers the ActiveRecordExtension extension from contrib
    register Sinatra::ActiveRecordExtension

    # @!method register_sinatra_config_file
    # @overload register Sinatra::ConfigFile
    # Registers the ConfigFile extension from contrib
    register Sinatra::ConfigFile

    # @!method register_sinatra_initializer
    # @overload register Sinatra::Initializer
    # Registers the {Sinatra::Initializer} local custom extension 
    register Sinatra::Initializer

    # @!method register_sinatra_authenticator
    # @overload register Sinatra::Authenticator
    # Registers the {Sinatra::Authenticator} local custom extension 
    register Sinatra::Authenticator

    # @!method config_file_config_yml
    # @overload config_file '../../config/config.yml'
    # Uses the Sinatra::ConfigFile extension method to load a yml
    #   config file
    config_file '../../config/config.yml'

    # @!method initialize_from_initializers
    # @overload initialize_from '../../config/initializers'
    # Uses the {Sinatra::Initializer} extension method to set up
    # Sinatra from initializers defined in '../../config/initializers'
    initialize_from File.expand_path '../../../config/initializers', __FILE__

    # @!method helpers_sinatra_json
    # @overload helpers Sinatra::JSON
    # Makes helper methods available from Sinatra::JSON in contrib
    helpers Sinatra::JSON

    # @!method helpers_helpers_auth_helper
    # @overload helpers {Helpers::AuthHelper}
    # Makes helper methods available from {Helpers::AuthHelper} 
    helpers Helpers::AuthHelper

    # @!method set_json_encoder 
    # @overload set :json_encoder, Lib::Encoders::JsonResourceEncoder
    # Overrides the default Sinatra::JSON JSON encoder to use the local
    # {Lib::Encoders::JsonResourceEncoder} instead
    set :json_encoder, Lib::Encoders::JsonResourceEncoder

    # @!method before_all
    # @overload before(/.*/)
    # Modifies any request that includes a .json suffix to also accept 
    # applicaiton/json content, then removes the suffix
    before(/.*/) do
      if request.url.match(/.json$/)
        request.accept.unshift('application/json')
        request.path_info = request.path_info.gsub(/.json$/,'')
      end
    end

    # @!method not_found
    # @overload not_found
    # Returns a response with a 404 status code, 'Not found'
    not_found do
      halt 404, 'Not found\n'
    end

    # @!method get_unauthorized
    # @overload get '/unauthorized'
    # Returns a response with a 401 status code, 'Not authorized'
    get '/unauthorized' do
      halt 401, 'Not authorized\n'
    end 

  end
end
