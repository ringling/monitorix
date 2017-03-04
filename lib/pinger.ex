defmodule Pinger do

  def ping(url, follow_redirect, httpoison \\ HTTPoison) do
    {ping_time, value}  = :timer.tc(fn -> Pinger.execute(url, follow_redirect, httpoison) end, [])
    value |> Map.put(:time, "#{ping_time/1000}ms")
  end

  def execute(url, follow_redirect, httpoison) do

    case httpoison.get(url, [], [follow_redirect: follow_redirect]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{status: 200, body: body}

      {:ok, %HTTPoison.Response{status_code: 301, body: body}} ->
        %{status: 301, body: body}

      {:ok, %HTTPoison.Response{status_code: 404, body: body}} ->
        %{status: 404, body: body}

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        %{status: 500}

      {:error, %HTTPoison.Error{reason: reason}} ->
        %{error: reason}
    end

  end
end

