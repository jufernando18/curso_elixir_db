defmodule CursoElixirDb.Task do

  import CursoElixirDb.HelperAccounts

  def insert_random() do
    create_accounts(%{type_document: "CC", num_document: 1234, email: "prueba@prueba.com.co", name_company: "PersonalSoft", name: "Juan Fernando", last_name: "Echavarria Zapata"})
  end
end
