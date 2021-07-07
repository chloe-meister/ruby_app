# frozen_string_literal: true

require 'socket'
Dir['resources/*.rb'].each { |file| require_relative file }
require_relative 'config/routes'

server = TCPServer.new 5678

loop do
  session = server.accept
  request = []
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end
  puts "Request #{request}"

  request_line = request[0]
  unless request_line.nil?
    # Create the routes
    routes = Routes.new

    # Resolve
    response = routes.resolve(request_line)

    # Send it
    session.print response
  end

  session.close
end
