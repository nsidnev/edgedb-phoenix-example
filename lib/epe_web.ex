defmodule EPEWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: EPEWeb

      import Plug.Conn
      alias EPEWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/epe_web/templates",
        namespace: EPEWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  defp view_helpers do
    quote do
      import Phoenix.View

      import EPEWeb.ErrorHelpers
      alias EPEWeb.Router.Helpers, as: Routes
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
