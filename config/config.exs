import Config

config :epe, EPEWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: EPEWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: EPE.PubSub,
  live_view: [signing_salt: "e7rxNE9v"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
