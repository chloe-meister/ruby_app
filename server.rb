# frozen_string_literal: true

require 'socket'
Dir['resources/*.rb'].each { |file| require_relative file }
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
    response = list.keys.include?(path) ? routes.resolve(method, path) : routes.resolve('GET', '/page-not-found')

    # Send it
    session.print response
  end

  session.close
end
