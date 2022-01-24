defmodule EPE.EdgeDB.Queries do
  @priv_dir :code.priv_dir(:epe)
  @edgeql_queries_dir Path.join(@priv_dir, "edgeql")

  @queries [@edgeql_queries_dir, "*", "*.edgeql"] |> Path.join() |> Path.wildcard()
  @queries_hash :erlang.md5(@queries)

  for query_path <- @queries do
    @external_resource query_path
  end

  @driver_directive_regex ~r/.*# edgedb:\s*:(?<directive>.*)/

  defmacro __using__(opts \\ []) do
    {opts, _bindings} = Code.eval_quoted(opts, [], __CALLER__)
    edgedb_name = opts[:name]

    base_parts = Path.split(@edgeql_queries_dir)

    @queries
    |> Enum.reduce(%{}, fn path, acc ->
      query = File.read!(path)

      fun_name =
        path
        |> Path.rootname()
        |> Path.basename()

      dir_name = Path.dirname(path)
      new_module_attrs = Path.split(dir_name) -- base_parts

      module_name = Enum.map_join(new_module_attrs, ".", &String.capitalize/1)

      if funs = acc[module_name] do
        funs = Map.put(funs, fun_name, query)
        Map.put(acc, module_name, funs)
      else
        Map.put(acc, module_name, %{fun_name => query})
      end
    end)
    |> Enum.each(fn {module_name, funs} ->
      module_def = define_module(edgedb_name, funs)

      module_name = Module.concat(edgedb_name, module_name)
      Module.create(module_name, module_def, Macro.Env.location(__ENV__))
    end)
  end

  def __mix_recompile__? do
    new_hash =
      [@edgeql_queries_dir, "*", "*.edgeql"]
      |> Path.join()
      |> Path.wildcard()
      |> :erlang.md5()

    new_hash != @queries_hash
  end

  defp define_module(edgedb_name, module_funs) do
    for {fun_name, query} <- module_funs do
      fun_name = String.to_atom(fun_name)

      {driver_fun, query} =
        case Regex.named_captures(@driver_directive_regex, query) do
          %{"directive" => directive} ->
            query =
              @driver_directive_regex
              |> Regex.replace(query, "")
              |> String.trim()

            {directive, query}

          _other ->
            {"query", query}
        end

      driver_fun = String.to_atom(driver_fun)

      quote do
        @doc """
        ```edgeql
        #{unquote(query)}
        ```
        """
        def unquote(fun_name)(params \\ [], opts \\ []) do
          conn = Keyword.get(opts, :conn, unquote(edgedb_name))
          params = List.wrap(params)
          EdgeDB.unquote(driver_fun)(conn, unquote(query), params, opts)
        end
      end
    end
  end
end
