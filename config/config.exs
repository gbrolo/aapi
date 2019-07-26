# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :aapi,
  ecto_repos: [Aapi.Repo]

# Configures the endpoint
config :aapi, AapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MA1fyUuaFIPaCkujm2izkLTlkmAzzt5Th2RdEbp0sgyU+jrUGRRlia1AJNSEnXwB",
  render_errors: [view: AapiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Aapi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
