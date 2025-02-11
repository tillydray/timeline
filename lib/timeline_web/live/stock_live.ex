defmodule TimelineWeb.StockLive do
  require Logger
  use TimelineWeb, :live_view
  alias Timeline.TwelveData

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
    ~L"""
    <h2 class="text-2xl font-semibold mb-4">Available Stocks</h2>
    <p>Select a stock to see its time series data.</p>
    <div class="pagination">
      <%= if @page > 1 do %>
        <%= live_patch "← Prev",
          to: "/?api_key=#{@api_key}&page=#{@page-1}",
          class: "px-4 py-2 bg-blue-500 text-white text-sm rounded hover:bg-blue-600" %>
      <% end %>

      <span>Page <%= @page %> of <%= @total_pages %></span>

      <%= if @page < @total_pages do %>
        <%= live_patch "Next →",
          to: "/?api_key=#{@api_key}&page=#{@page+1}",
          class: "px-4 py-2 bg-blue-500 text-white text-sm rounded hover:bg-blue-600" %>
      <% end %>
    </div>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 p-4">
      <%= for stock <- @stocks do %>
        <div class="bg-white rounded-md p-4 shadow hover:shadow-lg transition-shadow">
          <!-- Using a string path instead of Routes.live_path() -->
          <%= live_patch "#{stock["name"]} (#{stock["symbol"]})",
                to: "/?api_key=#{@api_key}&symbol=#{stock["symbol"]}",
                class: "text-blue-500 hover:underline" %>
        </div>
      <% end %>
    </div>

    <div class="pagination">
      <%= if @page > 1 do %>
        <%= live_patch "← Prev",
          to: "/?api_key=#{@api_key}&page=#{@page-1}",
          class: "px-4 py-2 bg-blue-500 text-white text-sm rounded hover:bg-blue-600" %>
      <% end %>

      <span>Page <%= @page %> of <%= @total_pages %></span>

      <%= if @page < @total_pages do %>
        <%= live_patch "Next →",
          to: "/?api_key=#{@api_key}&page=#{@page+1}",
          class: "px-4 py-2 bg-blue-500 text-white text-sm rounded hover:bg-blue-600" %>
      <% end %>
    </div>
    <%= if @symbol do %>
      <div class="time-series">
        <h3>Time Series for <%= @symbol %></h3>
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Open</th>
              <th>High</th>
              <th>Low</th>
              <th>Close</th>
              <th>Volume</th>
            </tr>
          </thead>
          <tbody>
            <%= for data <- @time_series do %>
              <tr>
                <td><%= data["datetime"] %></td>
                <td><%= data["open"] %></td>
                <td><%= data["high"] %></td>
                <td><%= data["low"] %></td>
                <td><%= data["close"] %></td>
                <td><%= data["volume"] %></td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    <% else %>
    <% end %>
    """
  end
end
