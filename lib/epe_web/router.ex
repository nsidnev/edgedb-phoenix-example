defmodule EPEWeb.Router do
  use EPEWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EPEWeb do
    pipe_through :api

    resources "/movies", MovieController, only: [:index]
    resources "/persons", PersonController, only: [:index, :create]
  end
end
