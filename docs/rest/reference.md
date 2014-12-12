# Managed WebSocket REST API Resources

The base URI for all resources is ``https://your.mws.address/v1``

## Public Resources

Public Resources can be accessed with or without an access token (depending on configured permissions).

Resource                            | Description
----------------------------------- | -------------
[GET /websocket_uri](v1/get_websocket_uri) | Returns a websocket connection uri.
[POST /messages](v1/post_messages) | Sends a message to the websocket.

## Admin Resources

Admin Resources can be accessed only by using [security tokens](../key-concepts/authentication). Usually this API will be used from a
trusted environment (administrators, server-side software etc.).

### Sockets

Resource                            | Description
----------------------------------- | -------------
[GET /sockets](v1/get_sockets) | Returns a list of currently active socket ids.
[GET /sockets/:id](v1/get_sockets_id) | Returns a single socket object.
[POST /sockets](v1/post_sockets) | Creates a new socket object.
[DELETE /sockets/:id](v1/delete_sockets_id) | Deletes a socket object.

### Configuration

Resource                            | Description
----------------------------------- | -------------
[GET /configuration](v1/get_configuration) | Gets configuration.
[PUT /configuration](v1/put_configuration) | Updates a configuration.

### Webhooks

Resource                            | Description
----------------------------------- | -------------
[POST /webhook_receivers/enginio](v1/post_webhook_receivers/enginio) | Webhook receiver API for Enginio
