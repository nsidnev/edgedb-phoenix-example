defmodule PhxEdb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {EdgeDB, name: PhxEdb.EdgeDB},
      # Start the Telemetry supervisor
      PhxEdbWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxEdb.PubSub},
      # Start the Endpoint (http/https)
      PhxEdbWeb.Endpoint
      # Start a worker by calling: PhxEdb.Worker.start_link(arg)
      # {PhxEdb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxEdb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxEdbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
