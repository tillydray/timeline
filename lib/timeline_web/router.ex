defmodule TimelineWeb.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", TimelineWeb do
    pipe_through :browser

    live "/", StockLive, :index
  end
end
