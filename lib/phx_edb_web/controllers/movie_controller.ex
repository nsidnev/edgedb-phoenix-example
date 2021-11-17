defmodule PhxEdbWeb.MovieController do
  use PhxEdbWeb, :controller

  action_fallback PhxEdbWeb.FallbackController

  def index(conn, _params) do
    movies =
      EdgeDB.query!(
        PhxEdb.EdgeDB,
        """
        SELECT default::Movie {
          title,
          director: {
            full_name := .first_name ++ " " ++ .last_name
          },
          actors: {
            first_name,
            last_name
          }
        }
        FILTER .year = <int64>$release_year
        """,
        release_year: 2001
      )

    render(conn, "index.json", movies: movies)
  end
end
