defmodule TimelineWeb.Router do
  use TimelineWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", TimelineWeb, as: :timeline do
    pipe_through(:browser)

    live("/", StockLive, :index)
    live("/stock", StockDetailsLive, :index)
  end
end
