# MWS Server [![Build Status](https://travis-ci.org/qtcloudservices/mws.svg?branch=master)](https://travis-ci.org/qtcloudservices/mws)

Open source version of Qt Cloud Services: Managed WebSocket.

**Note**: this server will only support one websocket gateway (no multi-tenancy).

## Deploying to Qt Cloud Services

* create a new MAR application
* add MAR git remote
  * `git remote add qtc <git remote from console>`
* create a new MDB Redis database
* set following environment variables to MAR application:
  * `REDIS_HOST=<mdb redis host>`
  * `REDIS_PORT=<mdb redis port>`
  * `REDIS_PASSWORD=<mdb redis password>`
  * `APP_DOMAIN=<mar app domain>`
  * `SECURITY_TOKEN=<admin token, generate with your favorite tool>`
  * `ACCESS_CONTROL=<none/eds/custom>`
    * `none` public websocket
    * `eds` valid EDS OAuth2 token is required and checked against `EDS_PERMISSIONS` rules
    * `custom` server side code can deliver websockets to clients using `SECURITY_TOKEN`
  * set following only when `ACCESS_MODE=eds`
      * `EDS_BACKEND_ID=<EDS backend id>`
      * `EDS_PERMISSIONS=<EDS permissions json, for example: {"read": ["*"], "write": ["usergroups.123123123"]}>`
* deploy to MAR
  * `git push qtc master`

## Development

To run server:

```
bundle install
puma start
```

To run tests:

```
rspec spec/
```

## License

[MIT](LICENSE)
