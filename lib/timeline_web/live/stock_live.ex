defmodule TimelineWeb.StockLive do
  use TimelineWeb, :live_view

  alias Timeline.TwelveData

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, stocks: [])}
  end

  @impl true
  def handle_params(%{"api_key" => api_key}, _uri, socket) do
    stocks = TwelveData.fetch_stocks(api_key)
    {:noreply, assign(socket, stocks: stocks)}
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
    """
  end
end
