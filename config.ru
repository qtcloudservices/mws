Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'rack/cors'
require './server'
require './app/middlewares/websocket_backend'

use Rack::Cors do
  allow do
    origins '*'
    resource '/*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
  end
end
use Rack::CommonLogger, $logger
use WebsocketBackend

run Cuba
