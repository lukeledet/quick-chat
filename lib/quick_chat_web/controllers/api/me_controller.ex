defmodule QuickChatWeb.API.MeController do
  use QuickChatWeb, :controller

  def show(conn, _params) do
    render(conn, "show.json", user: conn.assigns.current_user)
  end
end
