# Authentication

Every request to MWS is authenticated. MWS supports the following authentication methods:

* **OAuth2 / Security Token** - Full access to MWS instance and resources.
* **OAuth2 / EDS Access Token** - Access to MWS is restricted with [Access Control Policy](access-control-policies.md).

It is also possible to make requests to MWS without authentication. In this case, only the operations which do not enforce access control policies are made available.

## OAuth2 Security Token

The OAuth2 Security Token is used to access MWS without Access Control Policy restrictions. Every request to EDS has full privileges and you have full control over MWS. The OAuth2 Security Token is ideal when accessing MWS instance from a server side application.

### Setting OAuth2 Security Token

You can set the OAuth2 Security Token for your MWS installation through environment variable ``SECURITY_TOKEN``.

## OAuth2 EDS Access Token

The OAuth2 EDS Access Token is used to access MWS instance while enforcing the access control policy rules. The OAuth2 EDS Access Token is acquired from a configured EDS instance. For more information about how to get EDS access tokens, see [EDS authentication](/eds/key-concepts/security-authentication). An EDS Access Token is ideal when accessing MWS instance directly from the end user application.
