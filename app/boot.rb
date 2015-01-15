begin
  require 'dotenv'
  Dotenv.load
rescue LoadError
end

require 'logger'
require 'cuba'
require 'redis'
require 'redis/pool'
require 'redis_orm'
require 'mutations'

require_relative 'models/user'
require_relative 'models/websocket_client'
require_relative 'models/websocket_message'
require_relative 'models/websocket_uri'

class ::Logger; alias_method :write, :<<; end

if ENV['RACK_ENV'] == 'production'
  default_log_level = Logger::INFO
else
  default_log_level = Logger::DEBUG
end
if ENV['LOG_LEVEL']
  log_level = ENV['LOG_LEVEL'].to_i
else
  log_level = default_log_level
end
$logger = Logger.new(STDOUT)
$logger.level = log_level

$redis = Redis::Pool.new(
    host: (ENV['REDIS_HOST'] || 'localhost'),
    port: (ENV['REDIS_PORT'] || 6379),
    password: ENV['REDIS_PASSWORD'],
    size: 20
)