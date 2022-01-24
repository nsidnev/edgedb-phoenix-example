defmodule EPEWeb.MovieController do
  use EPEWeb, :controller

  alias EPE.EdgeDB

  action_fallback EPEWeb.FallbackController

  def index(conn, %{"release_year" => release_year}) do
    case Integer.parse(release_year) do
      {release_year, ""} ->
        render(conn, "index.json",
          movies: EdgeDB.Movies.movies_by_release_year(release_year: release_year)
        )

      _other ->
        {:error, {:wrong_parameters, [:release_year]}}
    end
  end

  def index(conn, _params) do
    render(conn, "index.json", movies: EdgeDB.Movies.all_movies())
  end
end
