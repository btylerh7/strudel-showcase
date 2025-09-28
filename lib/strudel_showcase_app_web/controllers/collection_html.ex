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

    <section class="box-grid">
      <.albums albums={@albums} />
    </section>
    """
  end

  def edit_table(assigns) do
    ~H"""
    <table>
      <thead>
        <tr>
          <th>Title</th>
          <th>Artist</th>
          <th>Year</th>
          <th>Cover File Name</th>
          <th>Url Path</th>
        </tr>
      </thead>
      <tbody>
        <%= for album <- @albums do %>
          <tr>
            <td><a href={"/music-collection/edit/#{album.url_path}"}>{album.title}</a></td>
            <td>{album.artist}</td>
            <td>{album.release_date}</td>
            <td>{album.cover}</td>
            <td>{album.url_path}</td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  def edit_album(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="breadcrumbs">
        <p><a href="/music-collection/edit">Edit</a></p>
        <p>{@album.title} - {@album.artist}</p>
      </div>
      <h1>Edit album {@album.title}</h1>
      <form method="POST" action={"/music-collection/edit/#{@album.url_path}"}>
        <div class="form-control">
          <label for="title">Album Title</label>
          <input type="text" name="title" id="title" value={"#{@album.title}"} />
        </div>
        <div class="form-control">
          <label for="artist">Album Artist</label>
          <input type="text" name="artist" id="artist" value={"#{@album.artist}"} />
        </div>
        <div class="form-control">
          <label for="release_date">Year</label>
          <input type="text" name="release_date" id="release_date" value={"#{@album.release_date}"} />
        </div>
        <div class="form-control">
          <label for="cover">Cover Filename</label>
          <input type="text" name="cover" id="cover" value={"#{@album.cover}"} />
        </div>
        <div class="form-control">
          <label for="url_path">URL Path</label>
          <input type="text" name="url_path" id="url_path" value={"#{@album.url_path}"} />
        </div>
        <button type="submit" class="shadow-button">Update</button>
      </form>
      <h2>Preview:</h2>
      <.render_album
        album_cover={@album.cover}
        album_title={@album.title}
        album_artist={@album.artist}
        release_date={@album.release_date}
        url_path={@album.url_path}
      />
    </Layouts.app>
    """
  end
end
