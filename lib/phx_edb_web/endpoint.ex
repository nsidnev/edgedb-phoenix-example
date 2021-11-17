defmodule PhxEdbWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :phx_edb

  @session_options [
    store: :cookie,
    key: "_phx_edb_key",
    signing_salt: "KvUJosIa"
  ]

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
  plug Plug.Session, @session_options
  plug PhxEdbWeb.Router
end
