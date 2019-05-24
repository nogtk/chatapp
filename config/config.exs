# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chat_app,
  ecto_repos: [ChatApp.Repo]

# Configures the endpoint
config :chat_app, ChatAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+QxBANKZg1Iwet/K/MqrIgKct+pIypVCRq7EkacTzU8ypAfbCQ3ZzUge5+i1oG/m",
  render_errors: [view: ChatAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :arc,
  storage: Arc.Storage.S3,
  bucket: System.get_env("S3_BUCKET"),
  asset_host: System.get_env("S3_ASSET_HOST")

config :ex_aws,
  access_key_id: [{:system, "S3_ACCESS_KEY"}, :instance_role],
  secret_access_key: [{:system, "S3_SECRET_KEY"}, :instance_role],

  region: "ap-northeast-1",
  s3: [
    scheme: "https://",
    host: "s3.ap-northeast-1.amazonaws.com",
    region: "ap-northeast-1"
  ]

  # region: "ap-northeast-1",
  # s3: [
  #   scheme: "https://",
  #   host: "s3-ap-northeast-1.amazonaws.com",
  #   region: "ap-northeast-1"
  # ]
  # access_key_id: [{:system, System.get_env("S3_ACCESS_KEY")}, :instance_role],
  # secret_access_key: [{:system, System.get_env("S3_SECRET_KEY")}, :instance_role]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
