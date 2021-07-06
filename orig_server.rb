# frozen_string_literal: true

require 'socket'
require 'net/http'
require_relative 'app/views/error_404'

server = TCPServer.new 5678

PAGES = {
  '/' => 'Hi, welcome to the home page!',
  '/about' => 'About us: we are http hackers',
  '/news' => "We haven't made much news yet with this server, but stay tuned"
}.freeze

PAGE_NOT_FOUND = Error404.render

while session = server.accept
  request = session.gets
  method, path, version = request&.split(' ')
  puts "Received a #{method} request to #{path} with #{version}"

  if PAGES.keys.include? path
    status = '200 OK'
    response_body = PAGES[path]
  else
    status = '404 Not Found'
    response_body = PAGE_NOT_FOUND
  end

  # Build a proper HTTP response
  response = <<~HEREDOC
    HTTP/1.1 #{status}
    Content-Type: text/html

    #{response_body}
  HEREDOC

  # Send it
  session.print response
  session.close
end
