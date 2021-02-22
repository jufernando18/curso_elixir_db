defmodule CursoElixirDb.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :type_document, :string
      add :num_document, :integer
      add :email, :string
      add :name_company, :string
      add :name, :string
      add :last_name, :string

      timestamps()
    end

  end
end
