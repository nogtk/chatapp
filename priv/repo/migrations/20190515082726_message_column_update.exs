defmodule ChatApp.Repo.Migrations.MessageColumnUpdate do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      remove :room_id
      add :room_id, references(:rooms, on_delete: :delete_all)
    end
  end
end
