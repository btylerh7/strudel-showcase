defmodule StrudelShowcaseAppWeb.MusicAlbum do
  use StrudelShowcaseAppWeb, :html
  use Phoenix.LiveView

  attr :album_cover, :string, required: true
  attr :album_title, :string, required: true
  attr :album_artist, :string, required: true
  attr :release_date, :string, required: true

  def render_album(assigns) do
    ~H"""
    <article class="album" title="${albumTitle}">
      <img src={@album_cover} />
      <div>
        <h2>{@album_title}</h2>
        <p>{@album_artist} - {@release_date}</p>
      </div>
    </article>
    """
  end
end
