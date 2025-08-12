defmodule StrudelShowcaseAppWeb.CollectionController do
  use StrudelShowcaseAppWeb, :controller
  require Logger
  alias StrudelShowcaseApp.Repo
  alias StrudelShowcaseApp.Album

  def collection(conn, _params) do
    get_static_path = fn artist ->
      fn cover -> Phoenix.VerifiedRoutes.static_path(conn, "/albums/#{artist}/#{cover}.jpg") end
    end

    albums = [
      %{
        title: "Load",
        artist: "Metallica",
        release_date: "1996",
        cover: get_static_path.("Metallica").("load")
      }
    ]

    render(conn, :collection, albums: albums)
  end

  def detail(conn, %{"artist" => artist, "album" => album}) do
    url_path = artist <> "/" <> album
    album = Repo.get_by(Album, url_path: url_path)

    render(conn, :detail, album: album)
  end
end
