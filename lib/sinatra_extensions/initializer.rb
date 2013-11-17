require 'sinatra/base'

module Sinatra
  module Initializer

    # Includes all the Sinatra config/setup code from Initializer modules in the path
    # @param path [String] The directory where the initializers are stored
    def initialize_from(path)
      Dir.glob("#{path}/*.rb").each do |file|
        name = File.basename(file, '.rb').capitalize
        include Module.const_get('Initializers::' + name)
      end
    end
  end

  # Registers {#initialize_from_path} as a global Sinatra DSL method
  register Initializer
end
