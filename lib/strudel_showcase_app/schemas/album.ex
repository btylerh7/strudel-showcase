defmodule StrudelShowcaseApp.Album do
  use Ecto.Schema

  schema "albums" do
    field :url_path, :string
    field :title, :string
    field :artist, :string
    field :release_date, :string
    field :cover, :string
  end
end
