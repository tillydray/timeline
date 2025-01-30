defmodule Timeline.Cache do
  require Logger
  use GenServer

  @dets_file 'timeline_cache'

  @table __MODULE__
  @expiration_time :timer.hours(24)

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :ets.new(@table, [:named_table, :public, :set, {:read_concurrency, true}])
    {:ok, _file} = :dets.open_file(@dets_file, type: :set)
    {:ok, %{}}
  end

  def get(key) do
    current_time = :erlang.system_time(:millisecond)

    case :ets.lookup(@table, key) do
      [{^key, {value, timestamp}}] when current_time - timestamp < @expiration_time ->
        Logger.info("Returning from ETS for #{inspect(key)}")
        value

      _ ->
        case :dets.lookup(@dets_file, key) do
          [{^key, {value, timestamp}}] when current_time - timestamp < @expiration_time ->
            Logger.info("Returning from DETS for #{inspect(key)}")
            :ets.insert(@table, {key, {value, timestamp}})
            value

          _ ->
            nil
        end
    end
  end

  def put(key, value) do
    :ets.insert(@table, {key, {value, :erlang.system_time(:millisecond)}})
    :dets.insert(@dets_file, {key, {value, :erlang.system_time(:millisecond)}})
    :ok
  end

  def terminate(_reason, _state) do
    :ok = :dets.close(@dets_file)
    :ok
  end
end
