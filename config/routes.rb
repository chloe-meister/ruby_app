require_relative '../resources/base_routes'

class Routes < BaseRoutes
  def define_routes
    get '/books', to: 'books#index'
    get '/error', to: 'errors#not_found'
  end
end
