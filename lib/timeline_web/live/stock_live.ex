defmodule TimelineWeb.StockLive do
  use TimelineWeb, :live_view

  alias Timeline.TwelveData

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, stocks: [])}
  end

  @impl true
  def handle_params(%{"api_key" => api_key, "symbol" => symbol}, _uri, socket) do
    stocks = TwelveData.fetch_stocks(api_key)
    time_series = TwelveData.fetch_time_series(symbol, api_key)

    {:noreply, assign(socket, stocks: stocks, time_series: time_series)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div class="stock-grid">
      <%= for stock <- @stocks do %>
        <div class="stock-item">
          <h3><%= stock["name"] %> (<%= stock["symbol"] %>)</h3>
          <p>Exchange: <%= stock["exchange"] %></p>
          <p>Currency: <%= stock["currency"] %></p>
        </div>
      <% end %>
    </div>

    <div class="time-series">
      <h3>Time Series Data</h3>
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
    """
  end
end
