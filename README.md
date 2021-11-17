# Example project that shows how to use the EdgeDB driver for Elixir with Phoenix

To run the server locally:
1. Initialize the EdgeDB project: `edgedb project init`
2. Start the Phoenix server: `mix phx.server`

Now this is a quite simple example with a single route `/api/movies` that will return data created by the `dbschema/migrations/00002.edgeql` migration.

This example will be improved later to show how to use various features of EdgeDB and Elixir driver for it a web application (e.g., custom codecs or something else).
