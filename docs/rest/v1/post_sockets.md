# POST /sockets

Creates a new WebSocket object. This API requires authorization with a security token.

## Example request

`POST https://your.mws.address/v1/sockets`

Request
```json
{
    "tags": ["players"]
}
```

Response

```json
{
    "id": "0UMTve5fpL2KgImPxFV36pVbLflX8A0S",
    "uri": "wss://your.mws.address?token=0UMTve5fpL2KgImPxFV36pVbLflX8A0S",
    "expiresAt": "2014-03-14T08:48:23Z",
    "tags": ["players"]
}
```
