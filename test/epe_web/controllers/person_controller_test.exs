defmodule EPEWeb.PersonControllerTest do
  use EPEWeb.ConnCase, async: false

  describe "GET /api/persons" do
    test "lists all peresons", %{conn: conn} do
      conn = get(conn, Routes.person_path(conn, :index))

      assert %{"persons" => persons} = json_response(conn, 200)

      expected_persons_names = ["Chris", "Daniel", "Rupert", "Emma"]

      for person <- persons do
        assert Enum.any?(expected_persons_names, fn name ->
                 person["first_name"] == name
               end)
      end
    end
  end

  describe "POST /api/persons" do
    test "lists all peresons", %{conn: conn} do
      first_name = "first_name"
      last_name = "last_name"

      conn =
        post(conn, Routes.person_path(conn, :create), %{
          "first_name" => first_name,
          "last_name" => last_name
        })

      assert %{
               "person" => %{
                 "id" => _id,
                 "first_name" => ^first_name,
                 "last_name" => ^last_name
               }
             } = json_response(conn, 200)
    end
  end
end
