defmodule Engpin.Repo do
  use Ecto.Repo,
    otp_app: :engpin,
    adapter: Ecto.Adapters.Postgres
end
