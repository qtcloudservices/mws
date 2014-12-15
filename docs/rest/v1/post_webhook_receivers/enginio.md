# POST /webhook_receivers/enginio

Receives [Enginio Webhook](https://developer.qtcloudservices.com/eds/key-concepts/webhooks) request and sends a websocket message to a gateway. This API requires authorization with a security token.

To configure Webhook on Enginio Dashboard:

1. Create new Webhook
2. Set url: 'https://your.mws.address/v1/webhook_receivers/enginio'
3. Select collections
4. Add custom header field: "Authorization": "Bearer [MWS Security Token]"
5. Save Webhook

## Example request

`POST https://your.mws.address/v1/webhook_receivers/enginio`

Request
```json
{
    "payload": {
        "object": {
            "id": "532edb9ee5bde5389403f0c2",
            "address" : {
                "city": "Springfield",
                "country": "USA"
            },
            "age": 32,
            "createdAt": "2014-03-23T13:03:26.504Z",
            "likes": ["pizza","coke"],
            "name": "John",
            "objectType": "objects.contacts",
            "updatedAt": "2014-04-02T17:33:09.449Z"
        },
        "meta":{
            "backendId": "532831a2698b3c6ae8091d6d",
            "eventName": "update"
        }
    },
    "receivers":[
        {"id":"*","objectType":"aclSubject"}
    ]
}
```