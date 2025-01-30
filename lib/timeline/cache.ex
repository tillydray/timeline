defmodule Timeline.Cache do
  use GenServer

  @dets_file 'timeline_cache'

  @table __MODULE__
  @expiration_time :timer.hours(24)

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :ets.new(@table, [:named_table, :public, :set, {:read_concurrency, true}])
    :ok = :dets.open_file(@dets_file, type: :set)
    {:ok, %{}}
  end

  def get(key) do
    current_time = :erlang.system_time(:millisecond)

    case :ets.lookup(@table, key) do
      [{^key, {value, timestamp}}] when current_time - timestamp < @expiration_time ->
        value

      _ ->
        case :dets.lookup(@dets_file, key) do
          [{^key, {value, timestamp}}] when current_time - timestamp < @expiration_time ->
            # Reinsert en ETS para acceso rápido
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
  def terminate(_reason, _state) when is_atom(_reason) and is_map(_state) do
    :dets.close(@dets_file)
    :ok
  end
