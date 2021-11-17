import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_edb, PhxEdbWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "T9vf8P5mOCHTSnmGL59E2b6b9T0MvyxSK1R9PtRoHxmT123WZkgN+7ZcG5DC/0JX",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
