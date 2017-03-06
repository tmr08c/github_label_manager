defmodule Github.RepositoryTest do
  use ExUnit.Case, async: "true"

  alias Github.{Repository, RepositoryTest}

  describe "listing an organizations repositories" do
    test "raises an error when no access token is given" do
      assert_raise Github.API.AccessTokenRequired, fn ->
        Github.Repository.all("") 
      end
    end


    test "returns a list of repos from the api" do
      defmodule TestAPIModule do
        @behaviour Github.API.Behaviour

        def all_repos(_) do
          [
            RepositoryTest.repo_response_factory("owner1", "repo1"),
            RepositoryTest.repo_response_factory("owner2", "repo2")
          ]
        end
      end

      repos = Github.Repository.all("access_token", TestAPIModule)

      assert repos == [
        %Repository{owner: "owner1", name: "repo1"},
        %Repository{owner: "owner2", name: "repo2"}
      ]
    end
  end

  # Based on https://developer.github.com/v3/repos/#response
  def repo_response_factory(owner_name, repo_name) do
    %{
      "id" => 1296269,
      "owner" => %{
        "login" => "#{owner_name}",
        "id" => 1,
        "avatar_url" => "https://github.com/images/error/#{owner_name}_happy.gif",
        "gravatar_id" => "",
        "url" => "https://api.github.com/users/#{owner_name}",
        "html_url" => "https://github.com/#{owner_name}",
        "followers_url" => "https://api.github.com/users/#{owner_name}/followers",
        "following_url" => "https://api.github.com/users/#{owner_name}/following{/other_user}",
        "gists_url" => "https://api.github.com/users/#{owner_name}/gists{/gist_id}",
        "starred_url" => "https://api.github.com/users/#{owner_name}/starred{/owner}{/repo}",
        "subscriptions_url" => "https://api.github.com/users/#{owner_name}/subscriptions",
        "organizations_url" => "https://api.github.com/users/#{owner_name}/orgs",
        "repos_url" => "https://api.github.com/users/#{owner_name}/repos",
        "events_url" => "https://api.github.com/users/#{owner_name}/events{/privacy}",
        "received_events_url" => "https://api.github.com/users/#{owner_name}/received_events",
        "type" => "User",
        "site_admin" => "false"
      },
      "name" => "#{repo_name}",
      "full_name" => "#{owner_name}/#{repo_name}",
      "description" => "This your first repo!",
      "private" => "false",
      "fork" => "false",
      "url" => "https://api.github.com/repos/#{owner_name}/#{repo_name}",
      "html_url" => "https://github.com/#{owner_name}/#{repo_name}",
      "archive_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/{archive_format}{/ref}",
      "assignees_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/assignees{/user}",
      "blobs_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/git/blobs{/sha}",
      "branches_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/branches{/branch}",
      "clone_url" => "https://github.com/#{owner_name}/#{repo_name}.git",
      "collaborators_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/collaborators{/collaborator}",
      "comments_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/comments{/number}",
      "commits_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/commits{/sha}",
      "compare_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/compare/{base}...{head}",
      "contents_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/contents/{+path}",
      "contributors_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/contributors",
      "deployments_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/deployments",
      "downloads_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/downloads",
      "events_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/events",
      "forks_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/forks",
      "git_commits_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/git/commits{/sha}",
      "git_refs_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/git/refs{/sha}",
      "git_tags_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/git/tags{/sha}",
      "git_url" => "git:github.com/#{owner_name}/#{repo_name}.git",
      "hooks_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/hooks",
      "issue_comment_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/issues/comments{/number}",
      "issue_events_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/issues/events{/number}",
      "issues_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/issues{/number}",
      "keys_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/keys{/key_id}",
      "labels_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/labels{/name}",
      "languages_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/languages",
      "merges_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/merges",
      "milestones_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/milestones{/number}",
      "mirror_url" => "git:git.example.com/#{owner_name}/#{repo_name}",
      "notifications_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/notifications{?since, all, participating}",
      "pulls_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/pulls{/number}",
      "releases_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/releases{/id}",
      "ssh_url" => "git@github.com:#{owner_name}/#{repo_name}.git",
      "stargazers_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/stargazers",
      "statuses_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/statuses/{sha}",
      "subscribers_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/subscribers",
      "subscription_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/subscription",
      "svn_url" => "https://svn.github.com/#{owner_name}/#{repo_name}",
      "tags_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/tags",
      "teams_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/teams",
      "trees_url" => "http://api.github.com/repos/#{owner_name}/#{repo_name}/git/trees{/sha}",
      "homepage" => "https://github.com",
      "language" => nil,
      "forks_count" => 9,
      "stargazers_count" => 80,
      "watchers_count" => 80,
      "size" => 108,
      "default_branch" => "master",
      "open_issues_count" => 0,
      "has_issues" => "true",
      "has_wiki" => "true",
      "has_pages" => "false",
      "has_downloads" => "true",
      "pushed_at" => "2011-01-26T19:06:43Z",
      "created_at" => "2011-01-26T19:01:12Z",
      "updated_at" => "2011-01-26T19:14:43Z",
      "permissions" => %{
        "admin" => "false",
        "push" => "false",
        "pull" => "true"
      }
    }
  end
end
