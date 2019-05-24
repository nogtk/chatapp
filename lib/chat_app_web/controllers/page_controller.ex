defmodule ChatAppWeb.PageController do
  use ChatAppWeb, :controller
  def new(conn, _params) do
    render(conn, "new.html")
  end
  def enter(conn, %{"username" => name}) do
    render(conn, "index.html", name: name || "名無しさん")
  end
end
