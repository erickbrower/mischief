module Initializers
  module Pagination

    def self.included(base)
      base.class_eval do

        configure :production, :development, :test do |env|
          Kaminari.configure do |conf|
            conf.default_per_page = settings.pagination['default_per_page']
            conf.max_per_page = settings.pagination['max_per_page']
          end
        end
      end

    end
  end
end
