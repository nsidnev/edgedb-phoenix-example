# Example project that shows how to use the EdgeDB driver for Elixir with Phoenix

To run the server locally:
1. Initialize the EdgeDB project: `edgedb project init`
2. Seed data: `mix seeds.setup`
3. Start the Phoenix server: `mix phx.server`

Now this is a quite simple example with only few routes. This example will be improved later to show how to use various features of EdgeDB and Elixir driver for it a web application (e.g., custom codecs or something else).

# Compile time queries functions generation
Module `EPE.EdgeDB.Queries` is responsible for generating modules and functions for application. It does it by reading `.edgeql` files from `priv/edgeql/*` directory and generating appropriate modules for that.
Check `lib/epe_web/controllers/movie_controller.ex` for example.

# Deployment
This example can be deployed using [fly.io](https://fly.io).

Prerequisites:
1. Account on [fly.io](https://fly.io).
2. Already deployed EdgeDB instance. Check out [step-by-step guide](https://www.edgedb.com/docs/guides/deployment/fly_io) from EdgeDB.
3. [Configure instance](https://www.edgedb.com/docs/reference/configuration#client-connections) to allow long lived inactive connections. This is required because right now driver for Elixir doesn't handle queries retries when client disconnects:

```edgeql
configure instance set session_idle_timeout := <duration>'0';
```

Applications naming:
* Elixir application: `epe-app`
* EdgeDB instance: `epe-edgedb`
* PostgreSQL instance: `epe-postgres`

Steps:
1. Create production database: `MIX_ENV=prod mix edgedb.database.create`
2. Apply migrations: `MIX_ENV=prod mix edgedb.database.migrate`
3. Seed database with data (optional): `MIX_ENV=prod mix edgedb.seeds.setup`
4. Run `fly launch` to create application and discard deploy.
5. Run `flyctl secrets set SECRET_KEY_BASE=$(mix phx.gen.secret) EDGEDB_DSN=edgedb://edgedb:edgedb@epe-edgedb.internal/epe_prod` to setup Phoenix secret and DSN for EdgeDB.
6. Run `flyctl ssh console -a epe-edgedb -C "edgedb-show-secrets.sh --format=raw EDGEDB_SERVER_TLS_CERT" | flyctl secrets set -a epe-app EDGEDB_TLS_CA=-` to setup TLS certificate for EdgeDB. Note that this step must be performed outside of the phoenix application directory, because otherwise `flyctl` will ask you to confirm that you want to use the application for EdgeDB and the command will be stuck waiting forever.
7. Run `flyctl deploy` and wait until application starts up.
