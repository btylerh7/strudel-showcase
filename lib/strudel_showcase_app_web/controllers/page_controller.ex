defmodule StrudelShowcaseAppWeb.PageController do
  use StrudelShowcaseAppWeb, :controller
  require Logger

  @songs_list [
    %{href: "/a-little-roll", title: "A Little Roll Never Hurt Anyone"},
    %{href: "/good-luck-babe", title: "Good Luck Babe by Chappell Roan"},
    %{href: "/nighttime-chug", title: "Nighttime Chug"},
    %{href: "/synthetic-motor-oil", title: "Synthetic Motor Oil"},
    %{href: "/vengeance-is-mine", title: "Vengeance is Mine (From Sonic Adventure 2)"},
    %{href: "/rainy-afternoon-serenade", title: "Rainy Afternoon Serenade"},
    %{href: "/golden-experience", title: "Golden Experience"}
  ]

  def home(conn, _params) do
    projects = [
      %{
        title: "This Site!",
        description: """
          I have embraced learning to build a website with Elixir and Phoenix! Having fun so far! I have personal projects, 
          my music collection, and a showcase of the music I have made in Strudel! Go check them out!
        """,
        link: "https://github.com/btylerh7/strudel-showcase"
      },
      %{
        title: "Solitaire Game",
        description: """
          Do you, like me, have nostalgia for the Microsoft Solitaire game? I don't really like a lot of modern Microsoft products, but
          I sure am glad that one was created! I have decided to make my own Solitaire game using Love2D and the Lua programming language!
        """,
        link: "https://codeberg.org/btylerh7/solitaire-1"
      },
      %{
        title: "Dokusho iOS (Comic Reader)",
        description: """
          One of the hardest parts of learning Japanese for me is looking up words when I am viewing content that is not text, like a manga. 
          This application was born out of my desire to read manga from my self-hosted Komga server and be able to use OCR and Apple's Live
          Text to look up words quickly.
        """,
        link: "https://github.com/btylerh7/dokusho-ios"
      }
    ]

    render(conn, :home, projects: projects)
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
end
