# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :react_phoenix,
  ecto_repos: [ReactPhoenix.Repo]

# Configures the endpoint
config :react_phoenix, ReactPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "w21mdCLFk/bGQ/y6c4zrE4iplba7Q5wjI5XD2QOJ5nkj19b6Qv/kzek5V/809n2f",
  render_errors: [view: ReactPhoenixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ReactPhoenix.PubSub,
  live_view: [signing_salt: "ndA3/Lgg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
