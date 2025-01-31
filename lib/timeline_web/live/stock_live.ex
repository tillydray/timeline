defmodule TimelineWeb.StockLive do
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
    symbol = Map.get(params, "symbol")

    total_pages = 
      case length(stocks) do
        0 -> 1
        count -> div(count + 19, 20)  # integer division, rounding up
      end

    offset = (page - 1) * 20
    paged_stocks = Enum.slice(stocks, offset, 20)
    symbol = Map.get(params, "symbol")
    time_series = if symbol, do: TwelveData.fetch_time_series(symbol, api_key), else: []

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
    <div class="stock-grid">
      <%= for stock <- @stocks do %>
        <div class="stock-item">
          <!-- Using a string path instead of Routes.live_path() -->
          <%= live_patch "#{stock["name"]} (#{stock["symbol"]})",
                to: "/?api_key=#{@api_key}&symbol=#{stock["symbol"]}" %>
        </div>
      <% end %>
    </div>

    <div class="pagination">
      <%= if @page > 1 do %>
        <%= live_patch "Previous", to: "/?api_key=#{@api_key}&page=#{@page-1}" %>
      <% end %>
      
      <span>Page <%= @page %> of <%= @total_pages %></span>
      
      <%= if @page < @total_pages do %>
        <%= live_patch "Next", to: "/?api_key=#{@api_key}&page=#{@page+1}" %>
      <% end %>
    </div>
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
