# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix, :json_library, Jason
config :phoenix, :format_encoders, json: Jason

# General application configuration
config :quick_chat,
  ecto_repos: [QuickChat.Repo]

# Configures the endpoint
config :quick_chat, QuickChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HqgPPabaULSu2xsLgq4ppu42257vMSSCp4qf8aNFd+zZiNBmiFUD8pkLKm7nkz8v",
  render_errors: [view: QuickChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: QuickChat.PubSub,
  live_view: [
    signing_salt: "W7JLk92e"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :rollbax,
  enabled: false,
  environment: "dev"

config :quick_chat, QuickChat.Mailer, adapter: Bamboo.LocalAdapter

config :bamboo, :json_library, Jason

config :ex_aws,
  access_key_id: [System.get_env("AWS_ACCESS_KEY_ID"), :instance_role],
  secret_access_key: [System.get_env("AWS_SECRET_ACCESS_KEY"), :instance_role]

config :quick_chat, jwt_secret: "secret"

# see releases.exs for production config
config :quick_chat, cluster_topologies: []

config :quick_chat, email: {"QuickChat", "noreply@quick_chat.org"}

config :quick_chat, :pow,
  user: QuickChat.User,
  repo: QuickChat.Repo,
  web_module: QuickChatWeb,
  mailer_backend: QuickChat.Mailer,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  web_mailer_module: QuickChatWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
