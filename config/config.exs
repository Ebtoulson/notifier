# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :notifier, NotifierWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zPyxZJVIGSkZPM2M8a5qo8xTKcLE72i3O4UdzzttEB2hnhTZE/UTIHH3au6Cbz6k",
  render_errors: [view: NotifierWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Notifier.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# `connect_options` is passed directly to `AMQP.Connection.open/1`
config :task_bunny, hosts: [
  default: [
    # forwards to AMQP.Connection.open/1
    connect_options: [
      host: "localhost",
      port: 5672,
      username: "guest",
      password: "guest",
      heartbeat: 10,
      client_properties: [{"connection_name", :longstr, "demo"}]
    ]
  ]
]

config :task_bunny, queue: [
  namespace: "demo.",
  queues: [
    [name: "normal", jobs: :default, worker: [concurrency: 5]]
  ]
]

config :task_bunny, failure_backend: [
  TaskBunny.FailureBackend.Logger
  #, TaskBunnySentryWrapper
  #, CustomPrometheusReporter
]

# Supports Wobserver

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
