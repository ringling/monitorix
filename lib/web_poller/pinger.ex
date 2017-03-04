defmodule Pinger do

  def ping(target, httpoison \\ HTTPoison) do
    {ping_time, value}  = :timer.tc(fn -> Pinger.execute(target, httpoison) end, [])
    value |> Map.put(:time, "#{ping_time/1000}ms")
  end

  def execute(target, httpoison) do

    case httpoison.get(target.url, [], [follow_redirect: target.follow_redirect]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{status: 200, body: body}

      {:ok, %HTTPoison.Response{status_code: 301, body: body}} ->
        %{status: 301, body: body}

      {:ok, %HTTPoison.Response{status_code: 404, body: body}} ->
        %{status: 404, body: body}

      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
        %{status: 500, body: body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        %{error: reason}
    end

  end
end

