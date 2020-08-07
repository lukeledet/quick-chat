defmodule QuickChat.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    setup()

    # Define workers and child supervisors to be supervised
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: QuickChat.PubSub},
      # Start the Ecto repository
      supervisor(QuickChat.Repo, []),
      # Start the endpoint when the application starts
      supervisor(QuickChatWeb.Endpoint, []),
      # Start your own worker by calling: QuickChat.Worker.start_link(arg1, arg2, arg3)
      # worker(QuickChat.Worker, [arg1, arg2, arg3]),
      {Cluster.Supervisor, [cluster_topologies(), [name: QuickChat.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuickChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QuickChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp cluster_topologies do
    enabled = Application.get_env(:quick_chat, :cluster_enabled)
    topologies = Application.get_env(:quick_chat, :cluster_topologies)

    if enabled, do: topologies, else: []
  end

  defp setup do
    QuickChatWeb.PipelineInstrumenter.setup()
    QuickChatWeb.Repo.Instrumenter.setup()
    Prometheus.Registry.register_collector(:prometheus_process_collector)
    QuickChatWeb.MetricsExporter.setup()

    :ok =
      :telemetry.attach(
        "prometheus-ecto",
        [:quick_chat, :repo, :query],
        &QuickChatWeb.Repo.Instrumenter.handle_event/4,
        %{}
      )
  end
end
