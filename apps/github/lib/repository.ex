defmodule Github.Repository do
  defstruct owner: "", name: ""

  alias Github.{API, Repository}

  @api_module API

  def all_for_org(access_token, org_name, api_module \\ @api_module) do
    Enum.map(api_module.org_repos(access_token, org_name), &to_struct/1)
  end

  defp to_struct(api_repository_response) do
    %Repository{
      owner: api_repository_response["owner"]["login"],
      name: api_repository_response["name"]
    }
  end
end
