defmodule CursoElixirDb.Repo do
  use Ecto.Repo,
    otp_app: :curso_elixir_db,
    adapter: Ecto.Adapters.Postgres
end
