# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :monitorix, Monitorix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TvFTXPxAG5sd5HH6X2QqcOwpgIEmi76dnOD+GrPgeYXkSNv6p4fVXqVnHaUQdEKl",
  render_errors: [view: Monitorix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Monitorix.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :quantum, :monitorix,
  cron: [

    every_5_minutes: [
      schedule: "*/5 * * * *",
      task: {Notifier, :ping},
      args: [5]
    ],
    every_minute: [
      schedule: "* * * * *",
      task: {Notifier, :ping},
      args: [1]
    ]
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
