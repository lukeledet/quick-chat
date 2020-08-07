defmodule QuickChatWeb.PowEmailConfirmation.MailerView do
  use QuickChatWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
