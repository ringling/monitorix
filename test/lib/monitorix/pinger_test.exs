defmodule PingerTest do
  use ExUnit.Case

  @httpoison_mock HTTPoisonMock
  #@httpoison_mock HTTPoison

  test "should ping site" do
    url = "http://web1.privacytree.eu/1"
    %{status: status, time: time, body: body} = Pinger.ping(url, false, @httpoison_mock)
    assert status == 200
    assert time
  end

  test "should follow redirects" do
    url = "http://www.privacytree.eu/da"
    %{status: status, time: time, body: body} = Pinger.ping(url, true, @httpoison_mock)
    assert status == 200
    assert time
  end

  test "should not follow redirects" do
    url = "http://www.privacytree.eu/da"
    %{status: status, time: time, body: body} = Pinger.ping(url, false, @httpoison_mock)
    assert status == 301
    assert time
  end

  test "should return error" do
    url = "https://web1.privacytree.eu"
    %{error: error, time: time} = Pinger.ping(url, false, @httpoison_mock)
    assert error == :econnrefused
    assert time
  end

end

defmodule HTTPoisonMock do


  def get("http://www.privacytree.eu/da", [], [follow_redirect: false]) do
    {:ok, %HTTPoison.Response{status_code: 301, body: "body"}}
  end

  def get("http://www.privacytree.eu/da", [], [follow_redirect: true]) do
    {:ok, %HTTPoison.Response{status_code: 200, body: "body"}}
  end

  def get("http://web1.privacytree.eu/1", [], _) do
    {:ok, %HTTPoison.Response{status_code: 200, body: "body"}}
  end

  def get("https://web1.privacytree.eu", [], _) do
    {:error, %HTTPoison.Error{reason: :econnrefused}}
  end

end
