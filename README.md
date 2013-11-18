mischief
========

A minimalist REST API boilerplate project that incorporates all the basic elements that a developer needs to jump start Getting Sh*t Done.

A simple bear can rest at ease.


### Familiar Structure
    - app
      - controllers
        - application_controller.rb   # The base Sinatra app
      - helpers
      - models
    - config
      - initializers                  # Modules for setting up the base app
      - config.yml                    # One application config yml file
      - boot.rb                       # Loads the current environment
    - db                              # Everybody loves ActiveRecord! <3  
      - migrate                       
        - 201311170...create_users.rb 
      - schema.rb
    - doc                             # Documentation with Yard
    - lib
    - test                            # MiniTest and Rack::Test::Methods
      - controllers
      - models
      - integration
      - factory.rb                    # Simple "factory" modules to aid testing
      - test_helper.rb                # Loads the test env and DB cleaner hooks
      - integration_test_helper.rb    # Loads the full app from config.ru
    - config.ru                       # Starts rack, and sets up the app routes
    - Rakefile                        
    - Gemfile                         # As few dependencies as possible


### Robotic Helper Gnomes
    rake console              # Start an app console
    rake db:create_migration  # create an ActiveRecord migration
    rake db:migrate           # migrate the database (use version with VERSION=n)
    rake db:rollback          # roll back the migration (use steps with STEP=n)
    rake db:schema:dump       # dump schema into file
    rake db:schema:load       # load schema into database
    rake test                 # Run tests with MiniTest
    rake yard                 # Generate project API documentation with Yard
    rake generate:model       # Generate an empty model and migration
    rake generate:resource    # Generate a model, migration, and scaffold controller

### The Gooey Center
* [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord) - via the [sinatra-activerecord](https://github.com/bmizerany/sinatra-activerecord) extension. 
* [MiniTest](https://github.com/seattlerb/minitest) and [database_cleaner](https://github.com/bmabey/database_cleaner)
* [Yard](http://yardoc.org/)
* sinatra/json and sinatra/config_file from [sinatra-contrib](https://github.com/sinatra/sinatra-contrib)


I work with Rails every day, but I'm still learning about all the great things Sinatra can do. This project is basically the result of trying to answer the question "But how would X work with Sinatra?", where X was ActiveRecord, then Warden and auth, then integration testing, etc. At the very least this project can provide some examples for how to go about those things. 

Work in progress! Feedback is welcome!

