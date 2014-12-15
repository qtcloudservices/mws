# GET /websocket_uri

Returns a WebSocket connection uri. Uri will expire after the returned *expiresAt* time.

## Example request

`GET https://your.mws.address/v1/websocket_uri`

Response

```json
{
    "uri": "wss://your.mws.address?token=aAYERijGJk4IKqHqpibbtNgdASh/SS85ncxeWIPKzqE=",
    "expiresAt": "2014-03-14T06:33:51Z",
    "tags": []
}
```
