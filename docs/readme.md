# Introduction to Managed WebSocket

> This is simplified, open source version of the Managed WebSocket ("MWS") which was originally part of Qt Cloud Services platform.

Managed WebSocket ("**MWS**") is a robust framework for scalable WebSocket server implementation. It is a RFC-6455 compliant WebSocket server implementation featuring:

* Scaling as your number of connections and data amounts increases.
* Access control for end users.
* Support for raw socket connections and binary data transfers.
* Deliver messages by socket id or delivery groups, tags.

MWS provides a reliable platform for serving any number of active WebSocket connections. Originally, the service was offered as part of Qt Cloud Services platform as SaaS solution.

## The Framework and Implementation

MWS is built with Ruby and is using Redis for messaging gateway between multiple applications.

* MWS supports distributed architecture and may be designed to scale automatically.
* For each socket connection, the client must request a WebSocket address. The authentication of client may be implemented at this stage. MWS may be integrated with [Enginio Data Storage](http://qtcloudservices.com/products/enginio-data-storage/) or have any custom authentication provider.
* It is possible to send messages to a list of receivers which may consist of socket ids or delivery groups, **tags**. More advanced logic may be implemented directly to application.

## Key Concepts

* [Authentication](key-concepts/authentication.md)
* [Access Control](key-concepts/access-control.md)
* [Communication Protocol](key-concepts/communication-protocol.md)
* [Socket Operations](key-concepts/socket-operations.md)

