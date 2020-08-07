defmodule QuickChatWeb.PowResetPassword.MailerView do
  use QuickChatWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
