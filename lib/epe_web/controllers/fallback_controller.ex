defmodule EPEWeb.FallbackController do
  use EPEWeb, :controller

  def call(conn, {:error, {:wrong_parameters, errors}}) do
    conn
    |> assign(:errors, errors)
    |> put_status(:unprocessable_entity)
    |> put_view(EPEWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(EPEWeb.ErrorView)
    |> render(:"404")
  end
end
