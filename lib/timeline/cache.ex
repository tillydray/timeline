defmodule Timeline.Cache do
  @moduledoc """
  Enhanced in-memory cache using ETS with expiration.
  """

  @table __MODULE__
  @expiration_time :timer.hours(24)

  def start_link do
    :ets.new(@table, [:set, :public, :named_table, {:read_concurrency, true}])
    {:ok, "Cache started"}
  end

  def get(key) do
    case :ets.lookup(@table, key) do
      [{^key, {value, timestamp}}] when :erlang.system_time(:millisecond) - timestamp < @expiration_time ->
        value
      _ ->
        nil
    end
  end

  def put(key, value) do
    :ets.insert(@table, {key, {value, :erlang.system_time(:millisecond)}})
    :ok
  end
end
