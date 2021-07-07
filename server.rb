# frozen_string_literal: true

require 'socket'
Dir['resources/*.rb'].each { |file| require_relative file }
require_relative 'config/routes'

server = TCPServer.new 5678

while session = server.accept
  loop do
    line = session.gets
    break if line == "\r\n" || line.nil?
  end

  request = session.gets
  puts request

  unless request.nil?
    # Create the routes
    routes = Routes.new

    # Resolve
    response = routes.resolve(request)

    # Send it
    session.print response
  end

  session.close
end
