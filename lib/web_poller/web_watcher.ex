defmodule WebWatcher do

  require Logger

  ## Client API

  @doc """
  Starts the web_watcher.
  """
  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end
  def start_link(targets) do
    GenServer.start_link(__MODULE__, targets, [name: __MODULE__])
  end
  def start_link(targets, name) do
    GenServer.start_link(__MODULE__, targets, [name: name])
  end

  def targets, do: targets(__MODULE__)
  def targets(server) do
    GenServer.call(server, {:targets})
  end

  def add_target(target), do: add_target(__MODULE__, target)
  def add_target(server, target) do
    GenServer.call(server, {:add_target, target})
  end

  def ping_targets(minute), do: ping_targets(__MODULE__, minute)
  def ping_targets(server, minute) do
    GenServer.call(server, {:ping_targets, minute})
  end

  ## Server Callbacks

  def init(targets) do
    {:ok, %{targets: targets, counter: 0}}
  end

  def handle_call({:targets}, _from, state) do
    {:reply, state.targets, state}
  end

  def handle_call({:add_target, target}, _from, state) do
    targets = [target | state.targets]
    state = state |> Map.put(:targets, targets)
    {:reply, :ok, state}
  end

  def handle_call({:ping_targets, minute}, _from, state) do

    state = %{state | counter: state.counter + 1}
    Logger.debug "#{state.counter}: PingTargets #{minute} - #{inspect DateTime.to_iso8601(DateTime.utc_now)}"

    {:reply, :ok, state}
  end

end
