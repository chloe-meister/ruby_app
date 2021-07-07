# frozen_string_literal: true

require 'socket'
Dir['resources/*.rb'].each { |file| require_relative file }
require_relative 'config/routes'
require 'uri'

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
    # extract headers
    headers = {}
    request.each do |line|
      if line.include?(': ')
        key, value = line.split(': ')
        headers[key] = value
      end
    end
    puts "Headers: #{headers}"

    content_length = headers['Content-Length']&.to_i
    puts "CL: #{content_length}"
    if content_length && headers['Content-Type'] == 'application/x-www-form-urlencoded'
      # extract body
      body = session.read(content_length)
      data = URI.decode_www_form(body).to_h
      puts "data: #{data}"
    end

    # Create the routes
    routes = Routes.new

    # Resolve
    response = routes.resolve(request_line)

    # Send it
    session.print response
  end

  session.close
end
