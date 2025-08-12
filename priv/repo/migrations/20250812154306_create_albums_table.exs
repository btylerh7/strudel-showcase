defmodule StrudelShowcaseApp.Repo.Migrations.CreateAlbumsTable do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :url_path, :string
      add :title, :string
      add :artist, :string
      add :release_date, :string
      add :cover, :string
    end
  end
end
