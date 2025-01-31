defmodule Timeline.TwelveData do
  @moduledoc """
  Fetches stock data from Twelve Data API.
  """

  require Logger
  alias Timeline.{Repo, RequestLog, Cache}

  @base_url "https://api.twelvedata.com"
  @default_interval "1day"

  def fetch_stocks(api_key) do
    endpoint = "/stocks?apikey=#{api_key}"

    case get_and_cache(endpoint) do
      {:error, _reason} ->
        []

      raw_body when is_binary(raw_body) ->
        # raw_body is still JSON, so parse it
        case Jason.decode(raw_body) do
          {:ok, %{"data" => data}} ->
            data

          _ ->
            []
        end
    end
  end

  def fetch_time_series(symbol, api_key, interval \\ @default_interval) do
    endpoint = "/time_series?symbol=#{symbol}&interval=#{interval}&apikey=#{api_key}"

    case get_and_cache(endpoint) do
      {:error, _reason} ->
        []

      raw_body when is_binary(raw_body) ->
        case Jason.decode(raw_body) do
          {:ok, %{"values" => values}} ->
            values

          _ ->
            []
        end
    end
  end

  def fetch_logo(symbol, api_key) do
    endpoint = "/logo?symbol=#{symbol}&apikey=#{api_key}"
    get_and_cache(endpoint)
  end

  def fetch_statistics(symbol, api_key) do
    endpoint = "/statistics?symbol=#{symbol}&apikey=#{api_key}"
    get_and_cache(endpoint)
  end

  # Wrapper to handle caching, logging, and HTTP GET.
  defp get_and_cache(endpoint) do
    # Check in-memory cache first
    case Cache.get(endpoint) do
      nil ->
        with {:ok, body} <- do_http_get("#{@base_url}#{endpoint}"),
             :ok <- log_request(endpoint) do
          Cache.put(endpoint, body)
          body
        else
          {:error, reason} -> {:error, reason}
        end

      cached ->
        cached
    end
  end

  defp do_http_get(url) do
    case :hackney.request(:get, url, [], "", []) do
      {:ok, 200, _headers, ref} ->
        {:ok, body} = :hackney.body(ref)
        {:ok, body}

      {:ok, status, _headers, ref} ->
        {:ok, error_body} = :hackney.body(ref)
        Logger.error("HTTP Error: #{status} - #{error_body}")
        {:error, :http_error}

      {:error, reason} ->
        Logger.error("Request error: #{inspect(reason)}")
        {:error, reason}
    end
  end

  defp log_request(endpoint) do
    # logs the timestamp of request to DB table
    %RequestLog{endpoint: endpoint, inserted_at: DateTime.truncate(DateTime.utc_now(), :second)}
    |> Repo.insert()

    :ok
  end
end
