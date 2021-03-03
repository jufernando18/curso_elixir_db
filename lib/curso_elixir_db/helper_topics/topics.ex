defmodule CursoElixirDb.HelperTopics.Topics do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :description, :string
    field :gradient, :string
    field :score, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(topics, attrs) do
    topics
    |> cast(attrs, [:title, :description, :score, :gradient])
    |> validate_required([:title, :description, :score, :gradient])
  end
end
