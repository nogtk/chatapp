defmodule ChatApp.Repo.Migrations.MessageBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :room_id, references(:rooms)
    end
  end
end
