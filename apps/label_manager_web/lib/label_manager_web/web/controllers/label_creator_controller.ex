defmodule LabelManagerWeb.Web.LabelCreatorController do
  use LabelManagerWeb.Web, :controller

  def index(conn, _params) do
    # TODO refactor this out; try to follow new Phoenix structure 

    repos = Github.Repository.all_for_org("access_token", "owner") 

    conn
    |> assign(:repos, repos)
    |> render("index.html")
  end

  def create(conn, params) do
    IO.inspect(params)
    conn
  end
end
