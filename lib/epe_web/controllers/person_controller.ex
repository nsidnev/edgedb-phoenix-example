defmodule EPEWeb.PersonController do
  use EPEWeb, :controller

  alias EPE.EdgeDB

  action_fallback EPEWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", persons: EdgeDB.Persons.all_persons())
  end

  def create(conn, %{"first_name" => first_name, "last_name" => last_name}) do
    with {:ok, person} <-
           EdgeDB.transaction(fn conn ->
             EdgeDB.Persons.create_new_person([first_name: first_name, last_name: last_name],
               conn: conn
             )
           end) do
      render(conn, "show.json", person: person)
    end
  end
end
