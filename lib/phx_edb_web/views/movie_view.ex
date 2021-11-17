defmodule PhxEdbWeb.MovieView do
  use PhxEdbWeb, :view

  alias PhxEdbWeb.MovieView

  def render("index.json", %{movies: movies}) do
    %{movies: render_many(movies, MovieView, "movie.json")}
  end

  def render("movie.json", %{movie: movie}) do
    %{
      id: movie.id,
      title: movie[:title],
      director: render_one(movie[:director], MovieView, "director.json", as: :director),
      actors: render_many(movie[:actors], MovieView, "actor.json", as: :actor)
    }
  end

  def render("director.json", %{director: director}) do
    %{
      id: director.id,
      full_name: director[:full_name]
    }
  end

  def render("actor.json", %{actor: actor}) do
    %{
      id: actor.id,
      first_name: actor[:first_name],
      last_name: actor[:last_name]
    }
  end
end
