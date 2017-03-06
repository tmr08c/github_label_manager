defmodule LabelManagerWeb.Web.PageController do
  use LabelManagerWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
