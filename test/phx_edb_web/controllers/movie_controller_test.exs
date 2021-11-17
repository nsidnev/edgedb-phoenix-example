defmodule PhxEdbWeb.MovieControllerTest do
  use PhxEdbWeb.ConnCase

  describe "index" do
    test "lists movies", %{conn: conn} do
      conn = get(conn, Routes.movie_path(conn, :index))

      assert %{
               "movies" => [
                 %{
                   "actors" => actors,
                   "director" => %{
                     "full_name" => "Chris Columbus"
                   },
                   "title" => "Harry Potter and the Philosopher's Stone"
                 }
               ]
             } = json_response(conn, 200)

      expected_actors_names = ["Daniel", "Rupert", "Emma"]

      for actor <- actors do
        assert Enum.any?(expected_actors_names, fn name -> actor["first_name"] == name end)
      end
    end
  end
end
