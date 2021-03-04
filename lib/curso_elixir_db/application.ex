defmodule CursoElixirDb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CursoElixirDb.Repo,
      # Start the Telemetry supervisor
      CursoElixirDbWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CursoElixirDb.PubSub},
      # Start the Endpoint (http/https)
      CursoElixirDbWeb.Endpoint,
      # Start a worker by calling: CursoElixirDb.Worker.start_link(arg)
      # {CursoElixirDb.Worker, arg}
      CursoElixirDb.Cron,
      {CursoElixirDb.Registry, name: CursoElixirDb.Registry}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CursoElixirDb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CursoElixirDbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
