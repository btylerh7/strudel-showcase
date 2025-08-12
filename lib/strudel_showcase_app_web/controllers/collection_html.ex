defmodule StrudelShowcaseAppWeb.CollectionHTML do
  @moduledoc """
  This module contains pages rendered by CollectionController.

  See the `collection_html` directory for all templates available.
  """
  alias StrudelShowcaseAppWeb.CollectionDetail
  use StrudelShowcaseAppWeb, :html
  use Phoenix.LiveComponent

  alias StrudelShowcaseApp.Repo
  alias StrudelShowcaseApp.Album

  embed_templates "collection_html/*"

  attr :album_cover, :string, required: true
  attr :album_title, :string, required: true
  attr :album_artist, :string, required: true
  attr :release_date, :string, required: true

  def render_album(assigns) do
    ~H"""
    <a class="collection-link" href={"/music-collection/#{@url_path}"}>
      <article class="album" title="${albumTitle}">
        <div class="cd-wrapper">
          <div class="cd-cover">
            <img class="album-cover" src={"/albums/#{@album_artist}/#{@album_cover}"} />
          </div>
          <div class="cd-case"></div>
        </div>
        <div>
          <h2>{@album_title}</h2>
          <p>{@album_artist} - {@release_date}</p>
        </div>
      </article>
    </a>
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
        url_path={album.url_path}
      />
    <% end %>
    """
  end

  def june(assigns) do
    collection_titles = [
      "metallica/load",
      "billie-eilish/hit-me-hard-and-soft",
      "pearl-jam/ten"
    ]

    album_list =
      Repo.all(Album)
      |> Enum.filter(fn album -> Enum.member?(collection_titles, album.url_path) end)

    assigns = assign(assigns, :albums, album_list)

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
