defmodule Github.Repository do
  defstruct owner: "", name: ""

  alias Github.{API, Repository}

  @api_module API

  def all(access_token, api_module \\ @api_module) do
    Enum.map(api_module.all_repos(access_token), &to_struct/1)
  end

  defp to_struct(api_repository_response) do
    %Repository{
      owner: api_repository_response["owner"]["login"],
      name: api_repository_response["name"]
    }
  end
end
