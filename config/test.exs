use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quick_chat, QuickChatWeb.Endpoint,
  http: [port: 4001],
  server: true

config :quick_chat, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :quick_chat, QuickChat.Repo,
  username: "postgres",
  password: "postgres",
  database: "quick_chat_test",
  hostname: "localhost",
  port: String.to_integer(System.get_env("PGPORT") || "5432"),
  pool: Ecto.Adapters.SQL.Sandbox,
  types: QuickChat.PostgresTypes

config :quick_chat, QuickChat.Mailer, adapter: Bamboo.TestAdapter

config :quick_chat,
  s3_signer: QuickChat.S3Signer.Mock

  config :hound,
  driver: "selenium",
  browser: "chrome",
  app_port: 4001,
  genserver_timeout: 480_000

config :cabbage,
  features: "test/integration/feature_files/"
