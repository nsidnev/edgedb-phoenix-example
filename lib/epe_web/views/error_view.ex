defmodule EPEWeb.ErrorView do
  use EPEWeb, :view

  def render("422.json", assigns) do
    %{
      errors: assigns[:errors]
    }
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
