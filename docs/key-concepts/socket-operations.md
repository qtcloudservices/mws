# Socket Operations

Sockets describe connections to MWS and they can be managed using a valid security token. Socket operations are handy when you want to have total control over WebSocket connections.

## Creating a new socket

When creating a new socket, MWS is basically creating just a placeholder for a socket connection. Creating a socket placeholder also allows you to define a list of tags that are attached to the socket. These tags and the returned id can be used as receivers when sending messages to connected clients. The returned `uri` should be passed to the connecting client. The client can then establish a websocket connection using `uri` before the `expiresAt` timestamp expires. The socket will be marked as active when the client has successfully established a connection to the WebSocket server.

**Example:** Create new socket object with tag "player1"

```sh
curl -XPOST -H "Authorization: Bearer {security_token}" \
    -d '{"tags": ["player1"]}'
    https://foo.qtcloudapp.com/v1/sockets
```

The returned json object has the following structure:

```javascript
{
    "id": "",           // socket id
    "uri": "",          // websocket connection uri
    "expiresAt": "",    // when socket uri expires
    "tags": []          // list of defined tags
}
```

## Listing active sockets

It is possible to list all of the active socket connections using the socket api. Listing will return an array of connected sockets:

```sh
curl -H "Authorization: Bearer {security_token}" \
    https://mws-eu-1.qtc.io/v1/sockets
```

Note that a newly created socket placeholder will not appear on this list until the client has established a connection.
