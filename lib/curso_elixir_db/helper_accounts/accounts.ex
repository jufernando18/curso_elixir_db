defmodule CursoElixirDb.HelperAccounts.Accounts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :email, :string
    field :last_name, :string
    field :name, :string
    field :name_company, :string
    field :num_document, :integer
    field :type_document, :string

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, [:type_document, :num_document, :email, :name_company, :name, :last_name])
    |> validate_required([:type_document, :num_document, :email, :name_company, :name, :last_name])
  end
end
