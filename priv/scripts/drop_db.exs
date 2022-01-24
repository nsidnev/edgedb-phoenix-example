database =
  :edgedb
  |> Application.get_all_env()
  |> Keyword.get(:database, "edgedb")

System.cmd("edgedb", ["query", "DROP DATABASE #{database}"])
