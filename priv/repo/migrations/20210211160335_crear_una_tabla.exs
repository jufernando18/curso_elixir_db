defmodule CursoElixirDb.Repo.Migrations.CrearUnaTabla do
  use Ecto.Migration

  def change do
    create table (:images) do
      add(:url, :text)
      add(:description, :text)
      add(:views, :integer, default: 0, null: false)
      timestamps()
    end
  end
end
