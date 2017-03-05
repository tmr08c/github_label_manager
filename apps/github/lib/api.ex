defmodule Github.API do
  @behaviour Github.API.Behaviour

  def org_repos(access_token, org_name) do
    access_token
    |> client
    |> repository_list(org_name)
  end

  defp client(access_token) when is_binary(access_token) and byte_size(access_token) == 0,  do: raise Github.API.AccessTokenRequired
  defp client(access_token) when is_binary(access_token), do: Tentacat.Client.new(%{access_token: access_token})

  defp repository_list(client, org_name), do: Tentacat.Repositories.list_orgs(org_name, client)
end

