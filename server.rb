require 'webrick'

server = WEBrick::HTTPServer.new :Port => 8000

server.start
