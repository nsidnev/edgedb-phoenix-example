import Config

config :epe, EPEWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "T9vf8P5mOCHTSnmGL59E2b6b9T0MvyxSK1R9PtRoHxmT123WZkgN+7ZcG5DC/0JX",
  server: false

config :logger, level: :warn

config :phoenix, :plug_init_mode, :runtime

config :edgedb,
  database: "epe_test"
