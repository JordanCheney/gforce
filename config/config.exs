# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gforce,
  ecto_repos: [Gforce.Repo]

# Configures the endpoint
config :gforce, GforceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zYARMut8dBtqllxbR7zQSeX4CycFateAfJwDzaxjtz3V7EY1hXOf6Q6qCTe7AOiS",
  render_errors: [view: GforceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gforce.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "dDQSfzyj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
