defmodule EPEWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :epe

  plug Corsica,
    origins: "*",
    allow_headers: ~w(
      authorization
      content-type
    )

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_epe_key",
    signing_salt: "KvUJosIa"

  plug EPEWeb.Router
end
