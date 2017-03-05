defmodule Github.API.Behaviour do
  @callback org_repos(access_token :: String.t, org_name :: Sring.t) :: list[map]
end
