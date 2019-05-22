defmodule ChatAppWeb.MessageController do
  use ChatAppWeb, :controller
  import Logger
  alias ChatApp.Message
  alias ChatApp.Repo
  def create(conn, %{"message" => message_params, "name" => name, "id" => room_id}) do
    changeset = Ecto.build_assoc(ChatApp.Room |> ChatApp.Repo.get(room_id), :messages)
    |> Message.changeset(%{image: message_params["image"], message: message_params["text"]})
    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> redirect(to: Routes.room_path(conn, :show, name, room_id))
    end
  end
end
