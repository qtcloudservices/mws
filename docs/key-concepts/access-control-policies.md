# Access Control Policies

MWS supports access control policies. These features can be used to grant secure and limited access to MWS.

## Access Control Modes

MWS may be configured to operate in one of the following access control modes:

| Mode | Description |
| ---- | ----------- |
| **none** | everyone has read/write permissions (without an access token) |
| **eds** | read/write permissions are defined using Access Control Policy; authentication is done using [Enginio Data Storage](http://qtcloudservices.com/products/enginio-data-storage/) |
| **custom** | connections to MWS are handled from custom server side code (using [socket operations](socket-operations.md)). Direct requests from the end-user application to MWS REST API are not allowed |

You can set the access control mode through environment variable ``ACCESS_CONTROL``.

## EDS Mode Features and Constrains

If you are using EDS access control mode, you are required to set following additional environment variables:

| Name     | Description |
| -------- | ----------- |
| **EDS_BACKEND_ID* | Valid Enginio Data Storage backend id |
| **EDS_PERMISSIONS** | EDS access control policy object. For example: ``{"read": ["*"], "write": ["usergroups.532c410072fc38d95600000b"]}``

With EDS mode, access control and permissions are automatically resolved using the EDS users and user groups. Access control policy is defined as a list of permissions with related subjects. A subject can be an EDS user group or an abstract target to all users.

```json
{
    "read": ["*"],
    "write": ["usergroups.532c410072fc38d95600000b", "usergroups.532c410072fc38d95600000c"]
}
```

In the above example everyone can connect to the MWS and receive messages. Only users that belong to defined user groups are allowed to send messages.

**Important!** If you want to target all users, you can use asterisk `*` as a subject.
