module Controllers
  class UsersController < ApplicationController
    # @!method authenticate!
    # @overload authenticate!
    # Hook that ensures authentication occurs before any controller action is run
    authenticate!

    # @!method get_index
    # @overload get '/'
    # Gets a paginated list of JSON-encoded{User}s
    get '/' do
      json User.order(:email).page(params['page']).per(params['per'])
    end

    # @!method get_show
    # @overload get '/:id'
    # Gets a JSON-encoded {User} by id
    get '/:id' do
      json User.find(params[:id])
    end

    # @!method post_create
    # @overload post '/'
    # Creates a new {User} from the data in the request body
    post '/' do
      data = JSON.parse(request.body.read.to_s)
      user = User.new(data)
      user.save
      json user
    end

    # @!method put_update
    # @overload put '/:id'
    # Updates a {User} by id
    put '/:id' do
      user = User.find(params[:id])
      data = JSON.parse(request.body.read.to_s)
      user.update_attributes(data)
      json user
    end

    # @!method delete_destroy
    # @overload delete '/:id'
    # Deletes a {User} by id
    delete '/:id' do
      json User.find(params[:id]).destroy
    end
  end
end
