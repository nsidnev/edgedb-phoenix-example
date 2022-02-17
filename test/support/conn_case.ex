defmodule EPEWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use EPEWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import EPEWeb.ConnCase

      alias EPEWeb.Router.Helpers, as: Routes

      @endpoint EPEWeb.Endpoint
    end
  end

  setup _context do
    conn = Phoenix.ConnTest.build_conn()
    :ok = EdgeDB.Sandbox.initialize(EPE.EdgeDB)

    on_exit(fn ->
      EdgeDB.Sandbox.clean(EPE.EdgeDB)
    end)

    %{conn: Plug.Conn.put_req_header(conn, "accept", "application/json")}
  end
end
