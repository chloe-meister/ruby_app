class BaseRoutes
  METHODS = [
    GET = 'GET',
    POST = 'POST',
    PUT = 'PUT',
    DELETE = 'DELETE'
  ]

  attr_reader :routes

  def initialize
    @routes = RoutesHash.new
    define_routes
  end

  def resolve(request, data = nil, store = nil)
    method, path, version = request.split(' ')
    puts "Received a #{method} request to #{path} with #{version}"

    # Check the route exists
    list = @routes.list(method)
    if list.keys.include?(path)
      controller_name, action = @routes.get(method, path)
      return unless controller_name && action

      require_relative "../app/controllers/#{controller_name}_controller"
      controller = self.class.const_get("#{controller_name.capitalize}Controller")

      controller.new(method, data, store).send(action)
    else
      # redirect to page not found
    end
  end

  class RoutesHash
    def initialize
      @hash = { GET => {}, POST => {}, PUT => {}, DELETE => {} }
    end

    def add(method, path, controller, action)
      @hash[method][path] = [controller, action]
    end

    def get(method, request_line)
      @hash.dig(method, request_line)
    end

    def list(method)
      @hash[method]
    end

    def list_all
      @hash
    end
  end

  private

  def match(path, method, opts={})
    controller, action = opts[:to].split('#')
    @routes.add(method, path, controller, action)
  end

  def post(path, opts={})
    match(path, POST, opts)
  end

  def get(path, opts={})
    match(path, GET, opts)
  end

  def define_routes; end
end

