# Communication Protocol

Managed WebSocket supports the RFC 6465 WebSocket protocol.

## Messaging Protocol

### Raw mode

The "Raw" mode does not enforce any messaging protocol. In raw mode all data messages are sent from a WebSocket server to connected clients as is. Bidirectional communication over WebSocket is not allowed. Pushing messages to connected clients is done by sending a POST request to REST API:

Here's an example how to send message with CURL:

```sh
curl -XPOST \
    -d '{"data": "Hello World!", \
        "receivers": {"sockets": ["*"], tags: null} \
        }' \
    https://foo.qtcloudapp.com/v1/messages
```

And this is an example how to send message using web browser (with jQuery):

```sh
var mwsUri = "https://foo.qtcloudapp.com/v1"
$.ajax({
    url: mwsUri + "/messages",
    type: "POST",
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    data: JSON.stringify({data: "Hello World!", receivers: {sockets: ['*'], tags: null}}),
    success: function(response) {
        console.log("Message sent", response)
    },
    error: function(response) {
        console.log("Ooops! Something went wrong!", response.responseText)
    }
})
```

## Message Routing

MWS has intelligent message routing that is based on socket id's and tags. Each message can be targeted to a single client, group of clients or all clients depending on application needs. Message targeting is done using `receivers` objects that contain a list of socket id's and/or socket tags:

```json
{
    "sockets": ["socket1", "socket2"],
    "tags": ["level1", "level2"]
}
```

**NOTE:** if you want to target all connection clients, use `["*"]` as the sockets' value.

## WebSocket Connection Keepalive

MWS will use WebSocket ping & pong control frames to keep the connection alive and to track live connections. MWS will send a ping message to connected clients every 50 seconds and it expects clients to respond with a pong message. This protocol is usually handled transparently with all WebSocket client libraries that support the RFC 6455 WebSocket protocol.
