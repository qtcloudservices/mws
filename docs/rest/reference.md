# Managed WebSocket REST API Resources

The base URI for all resources is ``https://your.mws.address/v1``

## Public Resources

Public Resources can be accessed with or without an access token (depending on configured permissions).

Resource                            | Description
----------------------------------- | -------------
[GET /websocket_uri](v1/get_websocket_uri.md) | Returns a websocket connection uri.
[POST /messages](v1/post_messages.md) | Sends a message to the websocket.

## Admin Resources

Admin Resources can be accessed only by using [security tokens](../key-concepts/authentication.md). Usually this API will be used from a
trusted environment (administrators, server-side software etc.).

### Sockets

Resource                            | Description
----------------------------------- | -------------
[GET /sockets](v1/get_sockets.md) | Returns a list of currently active socket ids.
[GET /sockets/:id](v1/get_sockets_id.md) | Returns a single socket object.
[POST /sockets](v1/post_sockets.md) | Creates a new socket object.
[DELETE /sockets/:id](v1/delete_sockets_id.md) | Deletes a socket object.

### Webhooks

Resource                            | Description
----------------------------------- | -------------
[POST /webhook_receivers/enginio](v1/post_webhook_receivers/enginio.md) | Webhook receiver API for Enginio
