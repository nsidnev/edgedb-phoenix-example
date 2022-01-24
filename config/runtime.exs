import Config

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  System.get_env("EDGEDB_DSN") ||
    raise "environment variable EDGEDB_DSN is missing"

  app_name =
    System.get_env("FLY_APP_NAME") ||
      raise "nvironment variable FLY_APP_NAME is missing"

  config :epe, EPEWeb.Endpoint,
    url: [host: "#{app_name}.fly.dev", port: 80],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    secret_key_base: secret_key_base,
    server: true
end
