defmodule ChatApp.Message do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "messages" do
    field :message, :string
    field :image, ChatApp.ImageUploader.Type
    # field :image, :string
    belongs_to :room, ChatApp.Room
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message])
    # |> validate_required([:message])
    |> cast_attachments(attrs, [:image])
  end

  def get_room_info(id) do
    ChatApp.Repo.get(ChatApp.Room, id) |> ChatApp.Repo.preload(:messages)
  end
end
