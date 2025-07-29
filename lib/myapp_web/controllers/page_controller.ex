defmodule MyappWeb.PageController do
  use MyappWeb, :controller

  def home(conn, _params) do
    songs = [
      %{href: "/a-little-roll", title: "A Little Roll Never Hurt Anyone"},
      %{href: "/good-luck-babe", title: "Good Luck Babe by Chappell Roan"},
      %{href: "/nighttime-chug", title: "Nighttime Chug"},
      %{href: "/synthetic-motor-oil", title: "Synthetic Motor Oil"},
      %{href: "/vengence-is-mine", title: "Vengence is Mine (From Sonic Adventure 2)"}
    ]

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, songs: songs, layout: false)
  end

  def strudel(conn, %{"song" => song}) do
    render(conn, :strudel, song: song)
  end
end
