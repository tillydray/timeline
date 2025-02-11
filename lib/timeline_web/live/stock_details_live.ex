defmodule TimelineWeb.StockDetailsLive do
  use TimelineWeb, :live_view
  alias Timeline.TwelveData

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"api_key" => api_key, "symbol" => symbol} = _params, _uri, socket) do
    time_series = TwelveData.fetch_time_series(symbol, api_key)
    {:noreply,
     socket
     |> assign(:api_key, api_key)
     |> assign(:symbol, symbol)
     |> assign(:time_series, time_series)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h2 class="text-2xl font-semibold mb-4">Time Series for <%= @symbol %></h2>
    <div class="time-series p-4 bg-white rounded-md shadow">
      <table class="min-w-full divide-y divide-gray-200">
        <thead>
          <tr>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Open</th>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">High</th>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Low</th>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Close</th>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Volume</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <%= for data <- @time_series do %>
            <tr>
              <td class="px-6 py-4 whitespace-nowrap"><%= data["datetime"] %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= data["open"] %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= data["high"] %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= data["low"] %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= data["close"] %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= data["volume"] %></td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end
end
