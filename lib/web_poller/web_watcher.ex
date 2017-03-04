defmodule WebWatcher do

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(targets) do
    GenServer.start_link(__MODULE__, targets, [])
  end


  def targets(server) do
    GenServer.call(server, {:targets})
  end

  def add_target(server, target) do
    GenServer.call(server, {:add_target, target})

  end


  ## Server Callbacks

  def init(targets) do
    {:ok, %{targets: targets}}
  end

  def handle_call({:targets}, _from, state) do
    {:reply, state.targets, state}
  end

  def handle_call({:add_target, target}, _from, state) do
    targets = [target | state.targets]
    state = state |> Map.put(:targets, targets)
    {:reply, :ok, state}
  end




end
