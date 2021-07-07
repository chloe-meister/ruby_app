class Routes < BaseRoutes
  def define_routes
    get '/books', to: 'books#index'
    get '/', to: 'books#index'
    get '/page-not-found', to: 'errors#not_found'
    get '/books/new', to: 'books#create'
  end
end
