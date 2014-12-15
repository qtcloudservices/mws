# Managed WebSocket REST API

The Managed WebSocket (**MWS**) REST API lets you interact with WebSocket server.

## Overview

The REST API in MWS is implemented using HTTP and REST principles. It is defined with the following aspects:

* The versioned base URI for the API: ```https://your.mws.address/v1```
* The internet media type of the data supported: ```JSON```
* The set of operations using HTTP methods: ```GET, PUT, POST and DELETE```

| Method       | Description  |
| ------------ | ------------ |
| GET | Lists objects or retrieves a single object. A safe method which has no side-effects as no data is modified. |
| PUT | Updates object. |
| POST | Creates a new object. |
| DELETE | Deletes object. |

The REST API provides a number of endpoints which follow previously presented principles. Please see [here](reference.md) for reference documentation on using the endpoints.

## Requests

MWS authenticates requests using the following HTTP headers:

* **Authorization** OAuth2 bearer access token (optional)

All communication is done using *application/json* content-type.

## Responses

MWS responds to all requests with *JSON* object. Successful requests are indicated with a *2xx* status code. *4xx*
Status codes indicate failure. When a request fails, MWS responds with the following error JSON:

```json
{
    "error": {
        "reason": "<reason>",
        "message": "<message>"
    }
}
```

When a request for data is invalid, MWS responds with an array of validation errors:

```json
{
    "errors": [
        {
            "reason": "<reason>",
            "property": "<propertyName>",
            "message": "<message>"
        }
    ]
}
```

### Errors

MWS attempts to use appropriate HTTP status codes to indicate the error.

* ```400``` Bad request, request is invalid.
* ```401``` Unauthorized, endpoint or resource requires that the user is logged in.
* ```403``` Forbidden, requested information cannot be accessed by the acting user.
* ```404``` Not found, endpoint or resource does not exist.
* ```422``` Request data is invalid.
* ```500``` Internal server error, MWS is unhappy. The request is probably valid but needs to be retried later.
