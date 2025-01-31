defmodule TimelineWeb.StockLive do
  use TimelineWeb, :live_view
  alias Timeline.TwelveData

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"api_key" => api_key} = params, _uri, socket) do
    stocks = TwelveData.fetch_stocks(api_key)
    symbol = Map.get(params, "symbol")
    time_series = if symbol, do: TwelveData.fetch_time_series(symbol, api_key), else: []

    {:noreply,
     socket
     |> assign(:api_key, api_key)
     |> assign(:stocks, stocks)
     |> assign(:symbol, symbol)
     |> assign(:time_series, time_series)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div class="stock-grid">
      <%= for stock <- @stocks do %>
        <div class="stock-item">
          <!-- Using a string path instead of Routes.live_path() -->
          <%= live_patch "#{stock["name"]} (#{stock["symbol"]})",
                to: "/?api_key=#{@api_key}&symbol=#{stock["symbol"]}" %>
        </div>
      <% end %>
    </div>

    <%= if @symbol do %>
      <div class="time-series">
        <h3>Time Series for <%= @symbol %></h3>
        <%= for data <- @time_series do %>
          <div class="time-series-item">
            <p>Date: <%= data["datetime"] %></p>
            <p>Open: <%= data["open"] %></p>
            <p>High: <%= data["high"] %></p>
            <p>Low: <%= data["low"] %></p>
            <p>Close: <%= data["close"] %></p>
            <p>Volume: <%= data["volume"] %></p>
          </div>
        <% end %>
      </div>
    <% else %>
      <p>Select a stock to see its time series data.</p>
    <% end %>
    """
  end
end
