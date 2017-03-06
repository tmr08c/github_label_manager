defmodule Github.API do
  @behaviour Github.API.Behaviour

  alias Tentacat.{Client, Repositories}
  alias Tentacat.Repositories.{Labels}

  def all_repos(access_token) do
    access_token
    |> client
    |> repository_list
  end

  def add_label_to_repo(access_token, repo_owner, repo_name, label_name, label_color) do
    access_token
    |> client
    |> repo_label_create(repo_owner, repo_name, label_name, label_color)
  end

  defp client(access_token) when is_binary(access_token) and byte_size(access_token) == 0,  do: raise Github.API.AccessTokenRequired
  defp client(access_token) when is_binary(access_token), do: Client.new(%{access_token: access_token})

  defp repository_list(client), do: Repositories.list_mine(client)

  defp repo_label_create(client, repo_owner, repo_name, label_name, label_color) do
    Labels.create(repo_owner, repo_name, %{name: label_name, color: label_color}, client)
  end
end

