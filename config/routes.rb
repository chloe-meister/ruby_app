class Routes < BaseRoutes
  def define_routes
    get '/books', to: 'books#index'
    get '/page-not-found', to: 'errors#not_found'
  end
end
