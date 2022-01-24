defmodule EPEWeb.PersonView do
  use EPEWeb, :view

  alias EPEWeb.PersonView

  def render("index.json", %{persons: persons}) do
    %{persons: render_many(persons, PersonView, "person.json")}
  end

  def render("show.json", %{person: person}) do
    %{person: render_one(person, PersonView, "person.json")}
  end

  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      first_name: person[:first_name],
      last_name: person[:last_name]
    }
  end
end
