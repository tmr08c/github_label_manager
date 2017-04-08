defmodule LabelManagerWeb.Web.SessionController do
  use LabelManagerWeb.Web, :controller

  def new(conn, _) do
    if current_access_token?(conn) do
      IO.puts("session controller - have current user")
      conn
      |> redirect(to: label_creator_path(conn, :index))
    else
      IO.puts("session controller - no current user")
      render conn, "new.html"
    end
  end

  def delete(conn, _) do
    LabelManagerWeb.Web.Plugs.Auth.logout(conn)
  end

  defp current_user?(conn) do
    conn.assigns.current_user
  end

  defp current_access_token?(conn) do
    conn.assigns.access_token
  end
end
