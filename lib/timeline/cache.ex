defmodule Timeline.Cache do
  use GenServer

  @table __MODULE__
  @expiration_time :timer.hours(24)

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :ets.new(@table, [:named_table, :public, :set, {:read_concurrency, true}])
    {:ok, %{}}
  end

  def get(key) do
    current_time = :erlang.system_time(:millisecond)

    case :ets.lookup(@table, key) do
      [{^key, {value, timestamp}}] when current_time - timestamp < @expiration_time ->
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
