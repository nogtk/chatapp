defmodule ChatAppWeb.PageController do
  use ChatAppWeb, :controller

  def index(conn, params) do
    render(conn, "index.html", name: params["name"] || "default")
  end
  def new(conn, _params) do
    render(conn, "new.html")
  end
end
