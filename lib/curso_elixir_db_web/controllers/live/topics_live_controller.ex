defmodule CursoElixirDbWeb.TopicsLiveController do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  alias CursoElixirDb.HelperTopics

  # def render(assigns) do
  #   ~L"""
  #   <table>
  #   <thead>
  #   <tr>
  #     <th>Title</th>
  #     <th>Description</th>
  #     <th>Score</th>
  #     <th>Gradient</th>
  #   </tr>
  #   </thead>
  #   <tbody>
  #   <%= for card <- @cards do %>
  #   <tr>
  #     <td><%= card.title %></td>
  #     <td><%= card.description %></td>
  #     <td><%= card.score %></td>
  #     <td><%= card.gradient %></td>
  #   </tr>
  #   <% end %>
  #   </tbody>
  #   </table>
  #   """
  # end

  def render(assigns) do
    Phoenix.View.render(CursoElixirDbWeb.TopicsView, "cards.html", assigns)
  end

  def mount(_params, _, socket) do
    if connected?(socket), do: :timer.send_interval(5000, self(), :update)

    cards = HelperTopics.list_topics()
    {:ok, assign(socket, :cards, cards)}
  end

  def handle_info(:update, socket) do
    cards = HelperTopics.list_topics()
    {:noreply, assign(socket, :cards, cards)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    card = HelperTopics.get_topics!(id)
    HelperTopics.delete_topics(card)
    cards = HelperTopics.list_topics()
    {:noreply, assign(socket, :cards, cards)}
  end

end
