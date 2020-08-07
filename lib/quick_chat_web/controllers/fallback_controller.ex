defmodule QuickChatWeb.FallbackController do
  use QuickChatWeb, :controller

  def call(conn, :not_found) do
    conn
    |> put_status(404)
    |> put_view(QuickChatWeb.ErrorView)
    |> render("404.html")
  end
end
