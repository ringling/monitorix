defmodule WebWatcherTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, web_watcher} = WebWatcher.start_link([], :test)
    {:ok, web_watcher: web_watcher}
  end

  test "should add targets", %{web_watcher: web_watcher} do
    target = %Target{url: "some_url"}

    assert WebWatcher.targets(web_watcher) == []

    WebWatcher.add_target(web_watcher, target)

    assert WebWatcher.targets(web_watcher) == [target]
  end

end
