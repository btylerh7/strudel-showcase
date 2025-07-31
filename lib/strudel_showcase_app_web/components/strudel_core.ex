defmodule StrudelShowcaseAppWeb.StrudelCore do
  use StrudelShowcaseAppWeb, :html
  use Phoenix.Component
  require Logger

  attr :path, :string, required: true
  attr :rest, :global

  def render_repl(assigns) do
    js_base_dir =
      Path.join([Application.app_dir(:strudel_showcase_app, "priv"), "static", "assets", "js"])

    full_file_path = Path.join(js_base_dir, assigns.path <> ".js")

    script_content =
      case File.read(full_file_path) do
        {:ok, content} ->
          content

        {:error, reason} ->
          Logger.error("Failed to read file")
      end

    assigns = assign(assigns, :script_content, script_content)

    ~H"""
    <.repl_buttons />
    <strudel-editor id="repl">
      <!--
      <%= raw script_content %>
      -->
    </strudel-editor>
    """
  end

  def repl_buttons(assigns) do
    ~H"""
    <p>
      Click into the editor and press <code>Ctrl + Enter</code>
      to start and <code>Ctrl + .</code>
      to stop. Alternatively, use the buttons below.
    </p>
    <div class="audio-controls">
      <button id="play">Play</button>
      <button id="stop">Stop</button>
      <button onclick="window.location.href='/'">Back to Song List</button>
    </div>

    <script defer>
      const repl = () => document.getElementById('repl');
      initStrudel({
          prebake: () => samples('github:tidalcycles/dirt-samples'),
      });
      document.getElementById('play').addEventListener('click', (e) => {
          e.preventDefault();
          repl().editor.repl.evaluate(repl().code)
      })
      document.getElementById('stop').addEventListener('click', (e) => {
          e.preventDefault();
          repl().editor.repl.stop();

      })
    </script>
    """
  end
end
