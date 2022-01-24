defmodule EPE.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {EdgeDB, name: EPE.EdgeDB},
      EPEWeb.Telemetry,
      {Phoenix.PubSub, name: EPE.PubSub},
      EPEWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: EPE.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    EPEWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
