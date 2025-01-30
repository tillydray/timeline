defmodule Timeline.Cache do
  @moduledoc """
  Simple in-memory cache using ETS.
  """

  @table __MODULE__

  def start_link do
    :ets.new(@table, [:set, :public, :named_table])
    {:ok, "Cache started"}
  end

  def get(key) do
    case :ets.lookup(@table, key) do
      [{^key, value}] -> value
      _ -> nil
    end
  end

  def put(key, value) do
    :ets.insert(@table, {key, value})
    :ok
  end
end
