defmodule QuickChatWeb.API.MeView do
  use QuickChatWeb, :view

  def render("show.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        email: user.email
      }
    }
  end
end
