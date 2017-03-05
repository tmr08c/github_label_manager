defmodule Github.API.Behaviour do
  @callback org_repos(access_token :: String.t, org_name :: Sring.t) :: list[map]

  @callback add_label_to_repo(
    access_token :: String.t,
    repo_owner :: String.t,
    repo_name :: String.t,
    label_name :: String.t,
    label_color :: String.t
  ) :: :ok | {:error, reason :: String.t}
end
