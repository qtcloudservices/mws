# GET /sockets

Returns a list of currently active WebSocket connections. This API requires authorization with a security token.

## Example request

`GET https://your.mws.address/v1/sockets`

Response

```json
{
    "results": [
        {
            "id": "0UMTve5fpL2KgImPxFV36pVbLflX8A0S",
            "connectedAt": "2014-03-23T11:04:25Z",
            "tags": ["players"]
        },
        {
            "id": "wGCb483fy9sLg5EVOHXFe3DmSXPJTA2W",
            "connectedAt": "2014-03-23T16:12:22Z",
            "tags": ["players", "admins"]
        },
    ]
}
```
