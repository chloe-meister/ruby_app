# frozen_string_literal: true

require 'socket'
require_relative 'config/routes'

server = TCPServer.new 5678

while session = server.accept
  request = session.gets

  unless request.nil?
    method, path, version = request.split(' ')
    puts "Received a #{method} request to #{path} with #{version}"

    routes = Routes.new

    # Check the route exists
    list = routes.routes.list(method)
    puts list
    response = list.keys.include?(path) ? routes.resolve(method, path) : routes.resolve('GET', '/page-not-found')

    # Send it
    session.print response
  end

  session.close
end
