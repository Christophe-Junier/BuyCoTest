# Require library
require 'webrick'
require 'json'

# Require files
require_relative 'modules/Validation'
require_relative 'modules/Db_connector'
require_relative 'controllers/HttpController'
require_relative 'models/Boxe'

# Init server
server = WEBrick::HTTPServer.new(:Port => 8000)

# Mount controller on '/' endpoint
server.mount "/", HttpController

# Enable shutdown on C-c
trap("INT"){ server.shutdown }

# Start server
server.start
