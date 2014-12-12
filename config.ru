require './server'
require './app/middlewares/websocket_backend'

use Rack::CommonLogger, $logger
use WebsocketBackend

run Cuba
