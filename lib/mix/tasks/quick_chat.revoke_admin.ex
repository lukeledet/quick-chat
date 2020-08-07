defmodule Mix.Tasks.QuickChat.RevokeAdmin do
  use Mix.Task

  alias QuickChat.{ReleaseTasks}

  @shortdoc "Revokes the given user admin access"

  @moduledoc """
  Revokes the given user admin access

  usage:

  mix quick_chat.revoke_admin <email>
  """

  @doc false
  def run([email]) do
    Mix.Task.run("app.start")
    ReleaseTasks.revoke_admin_access(email)
  end
end
