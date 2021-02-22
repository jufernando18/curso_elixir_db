defmodule CursoElixirDb.HelperAccountsTest do
  use CursoElixirDb.DataCase

  alias CursoElixirDb.HelperAccounts

  describe "accounts" do
    alias CursoElixirDb.HelperAccounts.Accounts

    @valid_attrs %{email: "some email", last_name: "some last_name", name: "some name", name_company: "some name_company", num_document: 42, type_document: "some type_document"}
    @update_attrs %{email: "some updated email", last_name: "some updated last_name", name: "some updated name", name_company: "some updated name_company", num_document: 43, type_document: "some updated type_document"}
    @invalid_attrs %{email: nil, last_name: nil, name: nil, name_company: nil, num_document: nil, type_document: nil}

    def accounts_fixture(attrs \\ %{}) do
      {:ok, accounts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HelperAccounts.create_accounts()

      accounts
    end

    test "list_accounts/0 returns all accounts" do
      accounts = accounts_fixture()
      assert HelperAccounts.list_accounts() == [accounts]
    end

    test "get_accounts!/1 returns the accounts with given id" do
      accounts = accounts_fixture()
      assert HelperAccounts.get_accounts!(accounts.id) == accounts
    end

    test "create_accounts/1 with valid data creates a accounts" do
      assert {:ok, %Accounts{} = accounts} = HelperAccounts.create_accounts(@valid_attrs)
      assert accounts.email == "some email"
      assert accounts.last_name == "some last_name"
      assert accounts.name == "some name"
      assert accounts.name_company == "some name_company"
      assert accounts.num_document == 42
      assert accounts.type_document == "some type_document"
    end

    test "create_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HelperAccounts.create_accounts(@invalid_attrs)
    end

    test "update_accounts/2 with valid data updates the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Accounts{} = accounts} = HelperAccounts.update_accounts(accounts, @update_attrs)
      assert accounts.email == "some updated email"
      assert accounts.last_name == "some updated last_name"
      assert accounts.name == "some updated name"
      assert accounts.name_company == "some updated name_company"
      assert accounts.num_document == 43
      assert accounts.type_document == "some updated type_document"
    end

    test "update_accounts/2 with invalid data returns error changeset" do
      accounts = accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = HelperAccounts.update_accounts(accounts, @invalid_attrs)
      assert accounts == HelperAccounts.get_accounts!(accounts.id)
    end

    test "delete_accounts/1 deletes the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Accounts{}} = HelperAccounts.delete_accounts(accounts)
      assert_raise Ecto.NoResultsError, fn -> HelperAccounts.get_accounts!(accounts.id) end
    end

    test "change_accounts/1 returns a accounts changeset" do
      accounts = accounts_fixture()
      assert %Ecto.Changeset{} = HelperAccounts.change_accounts(accounts)
    end
  end
end
