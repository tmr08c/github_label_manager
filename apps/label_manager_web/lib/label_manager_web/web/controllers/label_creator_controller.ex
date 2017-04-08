defmodule LabelManagerWeb.Web.LabelCreatorController do
  use LabelManagerWeb.Web, :controller

  alias LabelManagerWeb.Users.User
  alias Github.{Label, Repository}

  def index(conn, _params) do
    # TODO refactor this out; try to follow new Phoenix structure 

    repos = %User{access_token: "149501c6030ae6fc0b6cee01b0033c885db044dc"}
    |> User.list_repositories()


    conn
    |> assign(:repos, repos)
    |> render("index.html")
  end

  def create(conn, params) do
    IO.inspect(params)

    repos = params["repos"]
    |> Enum.filter_map(
      fn({repo_name, checked}) -> checked == "true" end,
    fn({repo_name, _}) ->
      [owner, repo] = String.split(repo_name, "/")
      %Github.Repository{owner: owner, name: repo}
    end
    )
    |> IO.inspect

    # Make a label
    # %{"color" => color, "name" => name} = params["label"]
    #  Label.new(name, String.replace(color, "#", ""))
    # |> Label.add(repos,  "149501c6030ae6fc0b6cee01b0033c885db044dc")

    # repos = %User{access_token: "149501c6030ae6fc0b6cee01b0033c885db044dc"}
    # |> User.list_repositories()

    conn
    |> assign(:repos, repos) # when we render a different page we shouldn't need this
    |> render("index.html") # need to render a different page?
  end
end
