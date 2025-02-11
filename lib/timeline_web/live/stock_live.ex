defmodule TimelineWeb.StockLive do
  require Logger
  use TimelineWeb, :live_view
  alias Timeline.TwelveData
  import Phoenix.HTML.Link
  import TimelineWeb.Components.PaginationComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"api_key" => api_key} = params, _uri, socket) do
    page = Map.get(params, "page", "1") |> String.to_integer()
    stocks = TwelveData.fetch_stocks(api_key)

    total_pages =
      case length(stocks) do
        0 -> 1
        # integer division, rounding up
        count -> div(count + 19, 20)
      end

    offset = (page - 1) * 20
    paged_stocks = Enum.slice(stocks, offset, 20)
    symbol = Map.get(params, "symbol")
    time_series = if symbol, do: TwelveData.fetch_time_series(symbol, api_key), else: []
    Logger.info("[StockLive] Time series for #{inspect(symbol)}: #{inspect(time_series)}")
    Logger.info("[StockLive] Time series for #{inspect(symbol)}: #{inspect(time_series)}")

    {:noreply,
     socket
     |> assign(:api_key, api_key)
     |> assign(:stocks, paged_stocks)
     |> assign(:page, page)
     |> assign(:total_pages, total_pages)
     |> assign(:symbol, symbol)
     |> assign(:time_series, time_series)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h2 class="text-2xl font-semibold mb-4">Available Stocks</h2>
    <p>Select a stock to see its time series data.</p>
    <.pagination page={@page} total_pages={@total_pages} api_key={@api_key} />
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 p-4">
      <%= for stock <- @stocks do %>
        <%= link "#{stock["name"]} (#{stock["symbol"]})",
              to: "/stock?api_key=#{@api_key}&symbol=#{stock["symbol"]}",
              class: "bg-white rounded-md p-4 shadow hover:shadow-lg transition-shadow text-blue-600 hover:underline block" %>
      <% end %>
    </div>

    <.pagination page={@page} total_pages={@total_pages} api_key={@api_key} />
    """
  end
end
