defmodule CursoElixirDbWeb.PageController do
  use CursoElixirDbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
