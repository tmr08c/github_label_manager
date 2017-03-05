defmodule Github.Label do
  alias Github.{API, Label, Repository}

  defstruct name: "", color: ""

  @api API

  @spec new(String.t, String.t) :: %Label{}
  def new(name, color) do
    %Label{name: name, color: color}
  end

  def add(label, repos, access_token, api \\ @api)

  @spec add(%Label{}, [%Repository{}], String.t, module) :: [:ok | {:error, String.t}]
  def add(label, repos, access_token, api) when is_list(repos) do
    repos
    |> Enum.map(&Task.async(fn () -> add(label, &1, access_token, api) end))
    |> Enum.map(&Task.await/1)
  end

  @spec add(%Label{}, %Repository{}, String.t, module) :: :ok | {:error, String.t}
  def add(
    %Label{name: label_name, color: label_color},
    %Repository{owner: repo_owner, name: repo_name},
    access_token,
    api
  ) do
    case api.add_label_to_repo(access_token, repo_owner, repo_name, label_name, label_color) do
      {201, _resp} -> :ok
      {_bad_code, %{"errors" => errors}} -> {:error, errors}
    end
  end
end
