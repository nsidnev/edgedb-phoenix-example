import Config

# with esbuild to bundle .js and .css sources.
config :epe, EPEWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "KXn8mrLQsLTIeF63FkXyNuVevNhky43SY4gzuDULDPFmubx2BbNB5qfmhBYznR73",
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :edgedb,
  database: "epe_dev"
