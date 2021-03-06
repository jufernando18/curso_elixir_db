defmodule CursoElixirDb.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :description, :string
      add :score, :string
      add :gradient, :string

      timestamps()
    end

  end
end
