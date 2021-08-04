defmodule Gogls.Repo do
  use Ecto.Repo,
    otp_app: :gogls,
    adapter: Ecto.Adapters.Postgres
end
