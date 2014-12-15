# GET /sockets/:id

Returns a single WebSocket connection info. This API requires authorization with a security token.

## Example request

`GET https://your.mws.address/v1/sockets/0UMTve5fpL2KgImPxFV36pVbLflX8A0S`

Response

```json
{
    "id": "0UMTve5fpL2KgImPxFV36pVbLflX8A0S",
    "connectedAt": "2014-03-14T08:43:23Z",
    "tags": ["players"]
}
```
