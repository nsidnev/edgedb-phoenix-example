defmodule PhxEdbWeb.Router do
  use PhxEdbWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxEdbWeb do
    pipe_through :api

    resources "/movies", MovieController, only: [:index]
  end
end
