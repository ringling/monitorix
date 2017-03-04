defmodule WebPoller do

  def ping(url, httpoison \\ HTTPoison) do
    {ping_time, value}  = :timer.tc(fn -> WebPoller.execute(url, httpoison) end, [])
    value |> Map.put(:time, "#{ping_time/1000}ms")
  end

  def execute(url, httpoison) do

    case httpoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        %{status: 200}

      {:ok, %HTTPoison.Response{status_code: 301}} ->
        %{status: 301}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        %{status: 404}

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        %{status: 500}

      {:error, %HTTPoison.Error{reason: reason}} ->
        %{error: reason}
    end

  end
end

