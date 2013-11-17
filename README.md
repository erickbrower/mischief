mischief
========

A Sinatra starter kit for RESTful JSON APIs that includes pre-configured token- and session-based authentication, ActiveRecord ORM, query pagination, and integration testing. If [Rails](https://github.com/rails/rails) is a cargo plane, [mischief](http://github.com/erickbrower/mischief) is a fixie bicycle with wings. Everything you need to create trouble, or cure it. 


### A Familiar Structure
    - app
      - controllers
        - application_controller.rb   #The base Sinatra app
      - helpers
      - models
    - config
      - initializers                  #Modules for setting up the base app
      - config.yml                    #One application config yml file
      - boot.rb                       #Loads the current environment
    - db                              #Everybody loves ActiveRecord! <3  
      - migrate                       
        - 201311170...create_users.rb 
      - schema.rb
    - doc                             #Documentation with Yard
    - lib
    - test                            #MiniTest and Rack::Test::Methods
      - controllers
      - models
      - integration
      - factory.rb                    #Simple "factory" modules to aid testing
      - test_helper.rb                #Loads the test env and DB cleaner hooks
    - config.ru                       #Starts rack, and sets up the app routes
    - Rakefile                        #Helpful tasks
    - Gemfile                         #As few dependencies as possible


### Robotic Helper Gnomes
    rake console              # Start an app console
    rake db:create_migration  # create an ActiveRecord migration
    rake db:migrate           # migrate the database (use version with VERSION=n)
    rake db:rollback          # roll back the migration (use steps with STEP=n)
    rake db:schema:dump       # dump schema into file
    rake db:schema:load       # load schema into database
    rake test                 # Run tests with MiniTest
    rake yard                 # Generate project API documentation with Yard
    
My goal is to put together a minimalist REST API boilerplate kit that incorporates all the basic elements a developer needs to actually Get Things Done.