defmodule WebPollerTest do
  use ExUnit.Case

  test "should ping site" do
    url = "http://web1.privacytree.eu/1"
    %{status: status, time: time} = WebPoller.ping(url, HTTPoisonMock)
    assert status == 200
    assert time
  end

  test "should return error" do
    url = "https://web1.privacytree.eu"
    %{error: error, time: time} = WebPoller.ping(url, HTTPoisonMock)
    assert error == :econnrefused
    assert time
  end

end

defmodule HTTPoisonMock do

  def get("http://web1.privacytree.eu/1") do
    {:ok, %HTTPoison.Response{status_code: 200}}
  end

  def get("https://web1.privacytree.eu") do
    {:error, %HTTPoison.Error{reason: :econnrefused}}
  end

end
