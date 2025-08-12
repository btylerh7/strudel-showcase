defmodule StrudelShowcaseApp.Repo do
  use Ecto.Repo,
    otp_app: :strudel_showcase_app,
    adapter: Ecto.Adapters.SQLite3
end
