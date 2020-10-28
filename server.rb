require 'webrick'
require 'json'

require_relative 'modules/Validation'
require_relative 'modules/Db_connector'
require_relative 'controllers/HttpController'
require_relative 'models/Boxe'

server = WEBrick::HTTPServer.new(:Port => 8000)
server.mount "/", HttpController

# Enable shutdown on C-c
trap("INT"){ server.shutdown }
server.start
