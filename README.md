# MWS Server

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
  * `ADMIN_TOKEN=<admin token, generate with your favorite tool>`
  * `EDS_BACKEND_ID=<optional: if set, server will require admin or EDS token>`
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

MIT.
