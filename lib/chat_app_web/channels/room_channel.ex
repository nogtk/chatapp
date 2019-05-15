defmodule ChatAppWeb.RoomChannel do
  use Phoenix.Channel
  require Logger

  def join("room:" <> room_id, %{"room_id" => room_id}, socket) do
    Logger.debug room_id
    send(self(), {:after_join, room_id})
    {:ok, socket}
  end
  def handle_in("new_msg", %{"body" => body, "room_id" => room_id}, socket) do
    Ecto.build_assoc(ChatApp.Room |> ChatApp.Repo.get(room_id), :messages, %{message: body})
    |> ChatApp.Repo.insert
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_info({:after_join, room_id}, socket) do
    ChatApp.Message.get_room_info(room_id).messages
    |> Enum.each(fn msg -> push(socket, "new_msg", %{
      body: msg.message
    }) end)
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
