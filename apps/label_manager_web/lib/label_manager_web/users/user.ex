defmodule LabelManagerWeb.Users.User do
  defstruct access_token: ""

  alias LabelManagerWeb.Users.User
  alias Github.Repository

  @spec list_repositories(%User{}) :: [%Github.Repository{}]
  def list_repositories(%User{access_token: access_token}) do
    Repository.all(access_token)
  end
end

