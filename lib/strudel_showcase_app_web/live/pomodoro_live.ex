defmodule StrudelShowcaseAppWeb.PomodoroLive do
  use StrudelShowcaseAppWeb, :live_view
  require Logger

  def mount(_params, _session, socket) do
    time_in_minutes = fn x -> x * 60 end
    # number of seconds remaining
    starting_time = time_in_minutes.(25)
    time_remaining = starting_time
    time_remaining_formatted = format_time(starting_time)

    is_running = false

    socket =
      socket
      |> assign(:starting_time, starting_time)
      |> assign(:time_remaining, time_remaining)
      |> assign(:time_remaining_formatted, time_remaining_formatted)
      |> assign(:is_running, is_running)

    {:ok, socket}
  end

  def handle_event("toggle-type", _params, socket) do
    time_in_minutes = fn x -> x * 60 end

    starting_time =
      if socket.assigns.starting_time == time_in_minutes.(5) do
        time_in_minutes.(25)
      else
        time_in_minutes.(5)
      end

    time_remaining = starting_time
    time_remaining_formatted = format_time(starting_time)

    socket =
      socket
      |> assign(:starting_time, starting_time)
      |> assign(:time_remaining, time_remaining)
      |> assign(:time_remaining_formatted, time_remaining_formatted)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <input type="hidden" id="remaining_input" value={@time_remaining} />
      <h1>Pomodoro Timer Page</h1>
      <p>
        Time Remaining:
        <span id="remaining" data-seconds={@time_remaining}>{@time_remaining_formatted}</span>
      </p>
      <input type="hidden" id="running" value={@is_running} />
      <input type="hidden" id="strudelsong" value='sound("brown").room(1).release(.5).attack(.5)' />
      <.javascript />
      <.timer_button dispatch_command="start_timer" button_text="Start Timer" />
      <.timer_button dispatch_command="stop_timer" button_text="Stop Timer" />
      <.timer_button dispatch_command="reset_timer" button_text="Reset Timer" />
      <button class="shadow-button" phx-click="toggle-type">
        Switch between focus and Rest Mode
      </button>

      <p>If you need some background noise:</p>
      <button class="shadow-button" onclick="playStrudel()">Start White Noise</button>
      <button class="shadow-button" onclick="stopStrudel()">Stop White Noise</button>
    </Layouts.app>
    """
  end

  def format_time(seconds) do
    minutes = trunc(seconds / 60)
    remaining_seconds = seconds - minutes * 60
    "#{minutes}:#{remaining_seconds}"
  end

  def timer_button(assigns) do
    ~H"""
    <button
      class="shadow-button"
      phx-click={JS.dispatch("strudel_showcase_app:#{@dispatch_command}", to: "body")}
    >
      {@button_text}
    </button>
    """
  end

  def javascript(assigns) do
    ~H"""
    <script>
      initStrudel();
      const playStrudel = () => sound("brown").room(1).release(.5).attack(.5).gain(1.5).play();
      const stopStrudel = () => hush();
    </script>
    <script>
      let shouldCountDown = false;
      function formatTime(seconds) {
        const minutes = Math.floor(seconds/60);
        const remainingSeconds = seconds - (minutes * 60);
        return `${minutes}:${remainingSeconds}`;

      }
      function countdown() {
        const remaining = () => document.getElementById("remaining");
        if (remaining().dataset.seconds <= 0) {
          stopStrudel();
        }
        if(shouldCountDown == true && remaining().dataset.seconds >= 0) {
          const current = remaining().dataset.seconds;
          const newValue = Number(current) - 1;
          remaining().innerText = formatTime(newValue);
          remaining().dataset.seconds = newValue;
          setTimeout(() => countdown(), 1000)
        }
      }

      window.addEventListener("strudel_showcase_app:start_timer", (e) => {
        shouldCountDown = true;
        setTimeout(() => countdown(), 1000)
      });
        window.addEventListener("strudel_showcase_app:stop_timer", (e) => {
        shouldCountDown = false;
        countdown();
      });
      window.addEventListener("strudel_showcase_app:reset_timer", (e) => {
        const remaining = () => document.getElementById("remaining");
        shouldCountDown = false;
        remaining().dataset.seconds = document.getElementById("remaining_input").value;
        remaining().innerText = formatTime(remaining().dataset.seconds);
      });
    </script>
    """
  end
end
