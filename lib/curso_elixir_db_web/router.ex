defmodule CursoElixirDbWeb.Router do
  use CursoElixirDbWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    #plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {CursoElixirDbWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CursoElixirDbWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/accounts", AccountsController
    resources "/topics", TopicsController
    live "/cards", TopicsLiveController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CursoElixirDbWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CursoElixirDbWeb.Telemetry
    end
  end
end
