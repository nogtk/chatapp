defmodule ChatAppWeb.RoomController do
  use ChatAppWeb, :controller
  alias ChatApp.Room
  alias ChatApp.Repo
  def index(conn, _params) do
    rooms = Room |> Repo.all
    render(conn, "index.html", rooms: rooms)
  end
end
