defmodule Monitorix do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Monitorix.Endpoint, []),
      worker(WebWatcher, [])
    ]

    opts = [strategy: :one_for_one, name: Monitorix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Monitorix.Endpoint.config_change(changed, removed)
    :ok
  end
end
