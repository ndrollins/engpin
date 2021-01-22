# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :engpin,
  ecto_repos: [Engpin.Repo]

# Configures the endpoint
config :engpin, EngpinWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YRUJmJ16b/MwDA9hbb860NBZFyqHGJo223PrO8o/o2FdkufEB02+zWYYttKrM59Z",
  render_errors: [view: EngpinWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Engpin.PubSub,
  live_view: [signing_salt: "J0ULoTWD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
