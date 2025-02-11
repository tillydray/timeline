defmodule TimelineWeb.Components.PaginationComponent do
  use Phoenix.Component

  def pagination(assigns) do
    ~H"""
    <div class="pagination flex justify-end">
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
    """
  end
end
