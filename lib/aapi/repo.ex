defmodule Aapi.Repo do
  use Ecto.Repo,
    otp_app: :aapi,
    adapter: Ecto.Adapters.Postgres
end
