defmodule Mix.Tasks.QuickChat.GrantAdmin.Test do
  use QuickChat.DataCase, async: true
  alias Mix.Tasks.QuickChat.GrantAdmin
  alias QuickChat.Users
  import ExUnit.CaptureIO

  test "quick_chat.make_admin" do
    user = insert(:user)

    assert capture_io(fn ->
             GrantAdmin.run([user.email])
           end) =~ "is now an admin"

    assert Users.get_user(user.id).role == "admin"
  end
end
