defmodule ChatApp.Repo.Migrations.RemoveNameColumn do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      remove :name
    end
  end
end
