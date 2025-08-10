defmodule StrudelShowcaseAppWeb.CollectionHTML do
  @moduledoc """
  This module contains pages rendered by CollectionController.

  See the `collection_html` directory for all templates available.
  """
  use StrudelShowcaseAppWeb, :html
  use Phoenix.LiveComponent

  embed_templates "collection_html/*"

  attr :album_cover, :string, required: true
  attr :album_title, :string, required: true
  attr :album_artist, :string, required: true
  attr :release_date, :string, required: true

  def render_album(assigns) do
    ~H"""
    <article class="album" title="${albumTitle}">
      <div class="cd-wrapper">
        <div class="cd-cover">
          <img class="album-cover" src={@album_cover} />
        </div>
        <div class="cd-case"></div>
      </div>
      <div>
        <h2>{@album_title}</h2>
        <p>{@album_artist} - {@release_date}</p>
      </div>
    </article>
    """
  end

  def albums(assigns) do
    ~H"""
    <%= for album <- @albums do %>
      <.render_album
        album_cover={album.cover}
        album_title={album.title}
        album_artist={album.artist}
        release_date={album.release_date}
      />
    <% end %>
    """
  end

  def june(assigns) do
    albums = [
      %{
        title: "Load",
        artist: "Metallica",
        release_date: "1996",
        cover: "/albums/Metallica/load.jpg"
      },
      %{
        title: "HIT ME HARD AND SOFT",
        artist: "Billie Eilish",
        release_date: "2024",
        cover: "/albums/Billie Eilish/HIT ME HARD AND SOFT.jpg"
      },
      %{
        title: "Ten",
        artist: "Pearl Jam",
        release_date: "1991",
        cover: "/albums/Pearl Jam/Ten.jpg"
      }
    ]

    assigns = assign(assigns, :albums, albums)

    ~H"""
    <h2>My June Music Collection</h2>
    <p>
      These are what I would consider my "albums of June". I listened to these either for the first time,
      or had a profound experience with, etc.
    </p>

    <section class="collection">
      <.albums albums={@albums} />
    </section>
    """
  end
end
