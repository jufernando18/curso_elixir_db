# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :curso_elixir_db,
  ecto_repos: [CursoElixirDb.Repo]

# Configures the endpoint
config :curso_elixir_db, CursoElixirDbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zbf1dlsge7CQWc3wqoXjofEkMGTY8JqBA4Kuclly4ShMobBKLP7BV/KOjk3fPEEK",
  render_errors: [view: CursoElixirDbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CursoElixirDb.PubSub,
  live_view: [signing_salt: "00Bsnw5ll9QprdCZsh6v8iaJJoFJXqAA"]

config :curso_elixir_db, CursoElixirDb.Cron,
  jobs: [
    # Every second
    #insert: [
    #  schedule: {:extended, "*/5 * * * *"},
    #  task: {CursoElixirDb.Task, :insert_random, []}
      #task: fn -> Exercises9.print_count() end
    #]
    #{{:extended, "* * * * *"}, fn -> Exercises9.print_count() end}
    {{:extended, "*/10 * * * *"}, fn ->CursoElixirDb.Exercises.Class11.save_relevant_info_from_view() end}
  ]

config :logger, level: :debug

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
