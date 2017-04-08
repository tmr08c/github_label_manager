defmodule LabelManagerWeb.Web.Plugs.Auth do
  @moduledoc """
  This plug handles authentication for users and should be
  used when routing to actions that should require a logged
  in user.

  This plug also provide `login` and `logout` helpers.
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if access_token?(conn) do
      conn
    else
      conn
      |> Phoenix.Controller.put_flash(:error, "Please sign in to Github")
      |> Phoenix.Controller.redirect(to: "/session/new")
      |> halt
    end
  end

  defp access_token?(conn) do
    conn.assigns.access_token
  end

  @doc """
  Used to log in user

  * Sets session variables for `user_id` and `access_token`
  * Redirects to root path
  * Uses `configure_session(renew: true)` to protect from session
  fixation attacks
  """
  def login(conn, user, access_token) do
    conn
    |> put_session(:access_token, access_token)
    |> configure_session(renew: true)
    |> Phoenix.Controller.redirect(to: "/")
  end

  @doc """
  Used to log users out.

  * Clears *entire* session
  * Redirect to login page
  """
  def logout(conn) do
    conn
    |> configure_session(drop: true)
    |> Phoenix.Controller.put_flash(:info, "You have been logged out!")
    |> Phoenix.Controller.redirect(to: "/")
  end
end
