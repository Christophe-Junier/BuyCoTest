require 'webrick'
require_relative 'config/HttpHandler'

server = WEBrick::HTTPServer.new(:Port => 8000)
server.mount "/", HttpHandler

# Enable shutdown on C-c
trap("INT"){ server.shutdown }
server.start
