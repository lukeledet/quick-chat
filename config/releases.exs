import Config
# NOTE: Runtime production configuration goes here

config :quick_chat, QuickChat.Repo,
  database: "secret:/quickchat/postgres_database",
  username: "secret:/quickchat/postgres_username",
  password: "secret:/quickchat/postgres_password",
  hostname: "secret:/quickchat/postgres_hostname",
  port: {"secret:/quickchat/postgres_port", fn val -> String.to_integer(val || "5432") end},
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :quick_chat, QuickChatWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT"))],
  url: [scheme: "https", host: System.get_env("APP_DOMAIN"), port: 443],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :rollbax,
  client_token: System.get_env("ROLLBAR_CLIENT_TOKEN"),
  access_token: System.get_env("ROLLBAR_SERVER_TOKEN"),
  environment: System.get_env("ROLLBAR_ENVIRONMENT"),
  enable_crash_reports: true,
  reporters: [QuickChat.RollbaxReporter],
  # TODO: turn on when your app is deployed
  enabled: false

config :quick_chat, QuickChat.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

config :quick_chat,
  jwt_secret: System.get_env("JWT_SECRET") || System.get_env("SECRET_KEY_BASE")

# Configure Cluster Nodes
app_name = System.get_env("APP_NAME") || "quick-chat"

config :quick_chat, cluster_enabled: System.get_env("CLUSTER_ENABLED") == "1"

config :quick_chat,
  cluster_topologies: [
    k8s: [
      strategy: Elixir.Cluster.Strategy.Kubernetes.DNS,
      config: [
        # the name of the "headless" service in the app's k8s configuration
        service: "#{app_name}-nodes",
        # the `app` tag applied to k8s resources for this app
        application_name: app_name
      ]
    ]
  ]
