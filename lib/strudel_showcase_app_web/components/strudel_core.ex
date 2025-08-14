defmodule StrudelShowcaseAppWeb.StrudelCore do
  use StrudelShowcaseAppWeb, :html
  use Phoenix.LiveView
  require Logger

  attr :path, :string, required: true
  attr :showRepl, :string, required: true
  attr :title, :string, required: false
  attr :rest, :global

  def render(assigns) do
    script_content = build_strudel_string(assigns.path)
    %{path: path, showRepl: showRepl, title: title} = assigns

    style =
      if showRepl == "true" do
        ""
      else
        "display: none !important;"
      end

    assigns = assign(assigns, :script_content, script_content)
    assigns = assign(assigns, :style, style)

    ~H"""
    <h1 :if={@title != "" && @showRepl == "true"}>{@title}</h1>
    <.repl_buttons showRepl={@showRepl} />
    <div style={@style}>
      <strudel-editor id="repl">
        <!-- <%= raw @script_content %> -->
      </strudel-editor>
    </div>
    """
  end

  def build_strudel_string(filename) do
    js_base_dir =
      Path.join([Application.app_dir(:strudel_showcase_app, "priv"), "static", "songs"])

    full_file_path = Path.join(js_base_dir, filename <> ".js")

    script_content =
      case File.read(full_file_path) do
        {:ok, content} ->
          content

        {:error, _reason} ->
          Logger.error("Failed to read file")
          ""
      end

    script_content
  end

  attr :showRepl, :string, required: true

  def repl_buttons(assigns) do
    %{showRepl: showRepl} = assigns
    Logger.info(assigns.showRepl)

    description_text =
      if showRepl == "true" do
        ~H"""
        <p>
          Click into the editor and press <code>Ctrl + Enter</code>
          to start and <code>Ctrl + .</code>
          to stop. Alternatively, use the buttons below.
        </p>
        """
      else
        ~H"""
        <p>
          Would you like some classic Shadow the Hedgehog background music but written by me
          with code? Of course you do! (Look at the Strudel Showcase for more!)
        </p>
        """
      end

    assigns = assign(assigns, :description_text, description_text)

    ~H"""
    <section class="control-wrapper">
      {@description_text}
      <p style="text-decoration: underline;">
        <strong>NOTE: Currently not working in Chrome for unknown reason.</strong>
      </p>
      <div class="audio-controls">
        <button class="shadow-button" id="play">Play</button>
        <button class="shadow-button" id="stop">Stop</button>
        <button
          :if={@showRepl == "true"}
          class="shadow-button"
          onclick="window.location.href='/songs'"
        >
          Back to Song List
        </button>
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
    </section>
    """
  end
end
