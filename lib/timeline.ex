defmodule Timeline do
  @moduledoc """
  Documentation for `Timeline`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Timeline.hello()
      :world

  """
  def list_stocks(api_key, page \\ 1, per_page \\ 10) do
    stocks = Timeline.TwelveData.fetch_stocks(api_key)
    Enum.chunk_every(stocks, per_page)
    |> Enum.at(page - 1, [])
  end
end
