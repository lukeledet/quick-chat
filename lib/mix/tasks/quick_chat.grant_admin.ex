defmodule Mix.Tasks.QuickChat.GrantAdmin do
  use Mix.Task

  alias QuickChat.{ReleaseTasks}

  @shortdoc "Grants the given user admin access"

  @moduledoc """
  Grants the given user admin access

  usage:

  mix quick_chat.grant_admin <email>
  """

  @doc false
  def run([email]) do
    Mix.Task.run("app.start")
    ReleaseTasks.grant_admin_permissions(email)
  end
end
