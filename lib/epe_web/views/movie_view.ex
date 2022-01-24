defmodule EPEWeb.MovieView do
  use EPEWeb, :view

  alias EPEWeb.{
    MovieView,
    PersonView
  }

  def render("index.json", %{movies: movies}) do
    %{movies: render_many(movies, MovieView, "movie.json")}
  end

  def render("movie.json", %{movie: movie}) do
    %{
      id: movie.id,
      title: movie[:title],
      director: render_one(movie[:director], MovieView, "director.json", as: :director),
      actors: render_many(movie[:actors], PersonView, "person.json")
    }
  end

  def render("director.json", %{director: director}) do
    %{
      id: director.id,
      full_name: director[:full_name]
    }
  end
end
