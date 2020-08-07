defmodule Mix.Tasks.QuickChat.RevokeAdmin.Test do
  use QuickChat.DataCase, async: true
  alias Mix.Tasks.QuickChat.RevokeAdmin
  alias QuickChat.Users
  import ExUnit.CaptureIO

  test "quick_chat.revoke_admin" do
    user = insert(:user)

    assert capture_io(fn ->
             RevokeAdmin.run([user.email])
           end) =~ "admin access revoked"

    assert Users.get_user(user.id).role == "user"
  end
end
