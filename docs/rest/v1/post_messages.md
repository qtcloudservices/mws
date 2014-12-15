# POST /messages

Sends a message.

## Payload structure

```json
{
    "data": "",
    "receivers": {
        "sockets": [],
        "tags": []
    }
}
```

| Property           | Description
| ------------------ | ---------------
| data | Message data encoded as a string.
| receivers | Message receivers.

## Example request

`POST https://your.mws.address/v1/messages`

Request body
```json
{
    "data": "Hello world!",
    "receivers": {
        "tags": null,
        "sockets": ["*"]
    }
}
```