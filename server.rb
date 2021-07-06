# tcp_server.rb
require 'socket'
require 'net/http'

server = TCPServer.new 5678

while session = server.accept
  request = session.gets
  puts request

  # Build a proper HTTP response
  response = <<~HEREDOC
    HTTP/1.1 200 OK

    Hello world! The time is #{Time.now}
  HEREDOC

  # Send it
  session.print response
  session.close
end
