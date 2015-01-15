require 'json'

module JsonApi

  def parse_json
    JSON.parse(req.body.read)
  rescue
    res.status = 422
    res.write JSON.dump({error: 'Invalid json'})
    halt(res.finish)
  end

  ##
  # @param [Fixnum] status
  # @param [Hash,Array] object
  def respond_json(status, object)
    res.status = status
    res.write(JSON.dump(object))
  end

  def logger
    $logger
  end
end
