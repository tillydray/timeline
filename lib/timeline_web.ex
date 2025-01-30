defmodule TimelineWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: TimelineWeb
      import Plug.Conn
      import TimelineWeb.Router.Helpers
      import TimelineWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/timeline_web/templates",
                        namespace: TimelineWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import TimelineWeb.Router.Helpers
      import TimelineWeb.ErrorHelpers
      import TimelineWeb.Gettext
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {TimelineWeb.LayoutView, "live.html"}

      import TimelineWeb.Router.Helpers
      import TimelineWeb.Gettext
    end
  end
end
