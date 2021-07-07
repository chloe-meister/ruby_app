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

  def resolve(method_token, request_line)
    controller_name, action = @routes.get(method_token, request_line)
    return unless controller_name && action

    require_relative "../app/controllers/#{controller_name}_controller"
    controller = self.class.const_get("#{controller_name.capitalize}Controller")
    controller.new(method_token).send(action)
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

