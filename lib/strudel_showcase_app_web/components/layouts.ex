defmodule StrudelShowcaseAppWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is rendered as component
  in regular views and live views.
  """
  use StrudelShowcaseAppWeb, :html

  embed_templates "layouts/*"

  def repl_embed(assigns) do
    ~H"""
    <script src="https://unpkg.com/@strudel/web@latest" />
    <script src="https://unpkg.com/@strudel/repl@latest" />
    """
  end

  def app(assigns) do
    navlinks = [
      %{href: "/", title: "Home"},
      %{href: "/songs", title: "Strudel Showcase"}
    ]

    assigns = assign_new(assigns, :navlinks, fn -> navlinks end)

    ~H"""
    <header>
      <img phx-track-static src={~p"/assets/images/ChaosEmeraldRed.png"} />
      <div class="header-text">
        <p class="title">Chaos Control</p>
        <p class="tagline">Life is chaotic, write fun html instead</p>
      </div>
      <nav class="nav">
        <%= for navlink <- @navlinks do %>
          <a href={navlink.href}>{navlink.title}</a>
        <% end %>
      </nav>
    </header>

    <main>
      {render_slot(@inner_block)}
    </main>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 h-3 w-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Hang in there while we get back on track")}
        <.icon name="hero-arrow-path" class="ml-1 h-3 w-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end
end
