defmodule ChatAppWeb.RoomController do
  use ChatAppWeb, :controller
  alias ChatApp.Room
  alias ChatApp.Repo
  def enter(conn, %{"username" => username}) do
    rooms = Room |> Repo.all
    render(conn, "index.html", rooms: rooms, username: username)
  end
  def index(conn, %{"name" => name}) do
    rooms = Room |> Repo.all
    render(conn, "index.html", rooms: rooms, username: name)
  end
  def show(conn, %{"id" => id, "name" => name}) do
    room = Room |> Repo.get(id)
    render(conn, "chatroom.html", room: room, name: name)
  end
  def new(conn, %{"name" => name}) do
    changeset = Room.changeset(%Room{}, %{})
    render(conn, "new.html", changeset: changeset, name: name)
  end
  def create(conn, %{"room" => room_params, "name" => name}) do
    changeset = Room.changeset(%Room{}, room_params)
    case Repo.insert(changeset) do
      {:ok, room} ->
        conn
        |> redirect(to: Routes.room_path(conn, :index, name))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, name: name)
    end
  end
  def delete(conn, %{"id" => id, "name" => name}) do
    room = Room |> Repo.get(id)
    Repo.delete(room)

    conn
    |> redirect(to: Routes.room_path(conn, :index, name))
  end
end
