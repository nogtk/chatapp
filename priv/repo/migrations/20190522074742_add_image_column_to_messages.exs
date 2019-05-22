defmodule ChatApp.Repo.Migrations.AddImageColumnToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :image, :string
    end
  end
end
