defmodule ChatAppWeb.PageController do
  use ChatAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def new(conn, _params) do
    render(conn, "new.html")
  end
end
