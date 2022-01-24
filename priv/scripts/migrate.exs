database =
  :edgedb
  |> Application.get_all_env()
  |> Keyword.get(:database, "edgedb")

System.cmd("edgedb", ["migrate", "--database", database])
