defmodule StrudelShowcaseAppWeb.PageController do
  use StrudelShowcaseAppWeb, :controller
  require Logger

  @songs_list [
    %{href: "/a-little-roll", title: "A Little Roll Never Hurt Anyone"},
    %{href: "/good-luck-babe", title: "Good Luck Babe by Chappell Roan"},
    %{href: "/nighttime-chug", title: "Nighttime Chug"},
    %{href: "/synthetic-motor-oil", title: "Synthetic Motor Oil"},
    %{href: "/vengence-is-mine", title: "Vengence is Mine (From Sonic Adventure 2)"},
    %{href: "/rainy-afternoon-serenade", title: "Rainy Afternoon Serenade"}
  ]

  def home(conn, _params) do
    render(conn, :home)
  end

  def songs(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :songs, songs: @songs_list, layout: false)
  end

  def strudel(conn, %{"song" => song}) do
    Logger.info("Song is " <> song)
    title_item = Enum.find(@songs_list, fn x -> x.href == "/" <> song end)
    Logger.info("Title is " <> title_item.title)

    title =
      if is_nil(title_item) do
        ""
      else
        title_item.title
      end

    render(conn, :strudel, song: song, title: title)
  end

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
end
