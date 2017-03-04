defmodule Notifier do

  def ping(minute) do
    WebWatcher.ping_targets(minute)
  end

end
