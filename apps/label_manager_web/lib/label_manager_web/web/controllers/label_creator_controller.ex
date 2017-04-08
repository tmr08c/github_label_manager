defmodule LabelManagerWeb.Web.LabelCreatorController do
  use LabelManagerWeb.Web, :controller

  alias LabelManagerWeb.Users.User
  alias LabelManagerWeb.Labels.Creator, as: LabelCreator

  def index(conn, _params) do
    repos =
      %User{access_token: conn.assigns.access_token}
      |> User.list_repositories()

    conn
    |> assign(:repos, repos)
    |> render("index.html")
  end

  def create(conn, params) do
    LabelCreator.create(
      params["repos"],
      params["label"],
      conn.assigns.access_token
    )

     conn
     |> redirect(to: label_creator_path(conn, :index))
  end
end
