defmodule ChatAppWeb.RoomController do
  use ChatAppWeb, :controller
  alias ChatApp.Room
  alias ChatApp.Repo
  # def index(conn, %{"username" => username}) do
  def index(conn, %{"username" => username}) do
    rooms = Room |> Repo.all
    render(conn, "index.html", rooms: rooms, username: username)
  end
  def show(conn, %{"id" => id, "name" => name}) do
    room = Room |> Repo.get(id)
    render(conn, "chatroom.html", room: room, name: name)
  end
end
