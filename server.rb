# frozen_string_literal: true

require 'socket'
require_relative 'config/routes'

server = TCPServer.new 5678

while session = server.accept
  request = session.gets
  session.close unless request

  method, path, version = request.split(' ')
  puts "Received a #{method} request to #{path} with #{version}"

  routes = Routes.new
  response = routes.resolve(method, path)

  # Send it
  session.print response
  session.close
end
