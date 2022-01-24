defmodule EPE.MixProject do
  use Mix.Project

  def project do
    [
      app: :epe,
      version: "0.0.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      elixirc_options: [
        warnings_as_errors: true
      ],
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        dialyzer: :test,
        credo: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.github": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_add_apps: [:ex_unit],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {EPE.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # phoenix
      {:phoenix, "~> 1.6.6"},
      {:phoenix_pubsub, "~> 2.0"},
      {:corsica, "~> 1.0"},
      {:plug_cowboy, "~> 2.5"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},

      # common
      {:jason, "~> 1.2"},

      # edgedb
      {:edgedb, git: "https://github.com/nsidnev/edgedb-elixir"},

      # dev
      {:credo, "~> 1.5", only: [:dev, :test]},
      {:ex_machina, "~> 2.7", only: :test},
      {:excoveralls, "~> 0.14", only: :test}
    ]
  end

  defp aliases do
    [
      "edgedb.seeds.setup": "run priv/scripts/seeds.exs",
      "edgedb.database.create": "run priv/scripts/create_db.exs",
      "edgedb.database.drop": "run priv/scripts/drop_db.exs",
      "edgedb.database.migrate": "run priv/scripts/migrate.exs"
    ]
  end
end
