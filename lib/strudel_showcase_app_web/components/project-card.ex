defmodule StrudelShowcaseAppWeb.ProjectCard do
  use StrudelShowcaseAppWeb, :html
  use Phoenix.Component
  require Logger

  attr :title, :string, required: true
  attr :link, :string, required: true
  attr :description, :string, required: true

  def card(assigns) do
    ~H"""
    <article class="card">
      <h3>{@title}</h3>
      <p>{@description}</p>
      <p><a href={@link} target="_blank">Source Code</a></p>
    </article>
    """
  end
end
