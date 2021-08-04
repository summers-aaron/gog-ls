# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gogls,
  ecto_repos: [Gogls.Repo]

# Configures the endpoint
config :gogls, GoglsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dL4VZ+l7dbJtXAauc3N5e8goNX5un/FmhRyAG5xD1PVAOLSo1kYxRx+jZTcTD1Vd",
  render_errors: [view: GoglsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gogls.PubSub,
  live_view: [signing_salt: "/2/BeeHN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
