defmodule LabelManagerWeb.Labels.Creator do
  alias Github.{Label, Repository}

  def create(repos, label, access_token) do
    repos = extract_repos(repos)
    label = extract_label(label)

    Label.add(label, repos, access_token)
  end

  defp extract_repos(repos) do
    repos
    |> Enum.filter_map(&selected?/1, &convert_to_repo/1)
  end

  defp selected?({_, checked}) do
    checked == "true" 
  end

  defp convert_to_repo({repo_name, _}) do
    [owner, repo] = String.split(repo_name, "/")

    %Repository{owner: owner, name: repo}
  end

  defp extract_label(%{"color" => color, "name" => name}) do
    Label.new(name, String.replace(color, "#", ""))
  end
end
