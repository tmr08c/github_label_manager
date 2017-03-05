defmodule Github.API.AccessTokenRequired do
  defexception message: "Valid Access Token required when working with the Github API"
end

