defmodule CursoElixirDb.Registry do
  use GenServer

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, map_names) do
    {:reply, Map.fetch(map_names, name), map_names} #sync
  end

  @impl true
  def handle_cast({:create, name, value}, map_names) do
    if Map.has_key?(map_names, name) do
      {:noreply, name} #async
    else
      {:noreply, Map.put(map_names, name, value)} #async
    end
  end

  @impl true
  def handle_cast({:create_all, cards}, _map_names) do
    for card <- cards, do: persist_card_info(card)
    {:noreply, %{}}
  end

  # Inicio del GenServer de Registry
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name, value) do
    GenServer.cast(server, {:create, name, value})
  end

  defp persist_card_info({title, description, score, gradient}) do
    import CursoElixirDb.HelperTopics
    current = %{title: title, description: description, score: score, gradient: gradient}
    case get_topics_by(%{title: title}) do
      nil -> create_topics(current)
      old -> update_topics(old, current)
    end
  end

  def create_all(server, cards) do
    GenServer.cast(server, {:create_all, cards})
  end
end
