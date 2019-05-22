defmodule ChatAppWeb.RoomChannel do
  use Phoenix.Channel
  require Logger

  def join("room:" <> room_id, %{"room_id" => room_id}, socket) do
    send(self(), {:after_join, room_id})
    {:ok, socket}
  end
  def handle_in("new_msg", %{"body" => body, "room_id" => room_id, "image" => image}, socket) do
    changeset = Ecto.build_assoc(ChatApp.Room |> ChatApp.Repo.get(room_id), :messages)
    |> ChatApp.Message.changeset(%{image: image, message: body})
    |> ChatApp.Repo.insert
    broadcast!(socket, "new_msg", %{body: body, image: image})
    {:noreply, socket}
  end

  def handle_in("new_img", %{"body" => body, "image" => image}, socket) do
    broadcast!(socket, "new_img", %{body: body, image: image})
    {:noreply, socket}
  end

  def handle_info({:after_join, room_id}, socket) do
    ChatApp.Message.get_room_info(room_id).messages
    |> Enum.each(fn msg -> push(socket, "new_msg", %{
      body: msg.message,
      image: ChatApp.ImageUploader.url({msg.image, msg}, :thumb)
    }) end)
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
