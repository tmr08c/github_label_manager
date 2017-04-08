defmodule LabelManagerWeb.Web.Router do
  use LabelManagerWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LabelManagerWeb.Web.Plugs.FetchCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LabelManagerWeb.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/session", SessionController, only: [:new, :delete], singleton: true
  end

  scope "/", LabelManagerWeb.Web do
    pipe_through [:browser, LabelManagerWeb.Web.Plugs.FetchCurrentUser] # Use the default browser stack

    get "/test", LabelCreatorController, :index
    post "/test", LabelCreatorController, :create
  end

  scope "/auth", LabelManagerWeb.Web do
    pipe_through :browser

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end
  # Other scopes may use custom stacks.
  # scope "/api", LabelManagerWeb.Web do
  #   pipe_through :api
  # end
end
