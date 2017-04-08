defmodule LabelManagerWeb.Web.PageController do
  use LabelManagerWeb.Web, :controller

  def index(conn, _params) do
    if conn.assigns.access_token do
      conn |> redirect(to: label_creator_path(conn, :index))
    else
      render conn, "index.html"
    end
  end
end
