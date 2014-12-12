require 'json'

module JsonApi

  def parse_json
    JSON.parse(req.body.read)
  rescue
    res.status = 422
    res.write JSON.dump({error: 'Invalid json'})
    halt(res.finish)
  end

  def logger
    $logger
  end
end
