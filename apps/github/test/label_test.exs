defmodule Github.LabelTest do
  use ExUnit.Case, async: "true"

  alias Github.{Label, Repository}

  test "creating a label" do
    assert Label.new("new label", "123456") == %Label{name: "new label", color: "123456"}
  end

  describe "successfully adding a label" do
    defmodule SuccessfulLabelTestAPI do
      @behaviour Github.API.Behaviour

      def add_label_to_repo(_token, repo_owner, repo_name, label_name, label_color) do
        {201,
         %{"color" => label_color, "default" => false, "id" => 1, "name" => label_name,
           "url" => "https://api.github.com/repos/#{repo_owner}/#{repo_name}/labels/#{label_name}"}
        }
      end
    end

    setup do
      %{
        repos: [
          %Repository{owner: "owner", name: "repo1"},
          %Repository{owner: "owner", name: "repo2"}
        ],
        label: %Label{name: "My New Label", color: "#abc123"}
      }
    end

    test "can add a label to a single repository", %{repos: repos, label: label} do
      repo1 = hd(repos)
      assert :ok == Label.add(label, repo1, "access_token", SuccessfulLabelTestAPI)
    end

    test "can add a label to multiple repositories", %{repos: repos, label: label} do
      assert [:ok, :ok] == Label.add(label, repos, "access_token", SuccessfulLabelTestAPI)
    end
  end

  describe "unsuccessfully adding a label" do
    defmodule UnSuccessfulLabelTestAPI do
      @behaviour Github.API.Behaviour

      def add_label_to_repo(_token, _repo_owner, _repo_name, _label_name, _label_color) do
        {422,
         %{"documentation_url" => "https://developer.github.com/v3/issues/labels/#create-a-label",
           "errors" => [%{"code" => "already_exists", "field" => "name", "resource" => "Label"},
                        %{"code" => "invalid", "field" => "color", "resource" => "Label"}],
           "message" => "Validation Failed"}}
      end
    end

    setup do
      %{
        repos: [
          %Repository{owner: "owner", name: "repo1"},
          %Repository{owner: "owner", name: "repo2"}
        ],
        label: %Label{name: "duplicate label", color: "invalid color"},
      }
    end

    test "can add a label to a single repository", %{repos: repos, label: label} do
      repo1 = hd(repos)
      error_response =  {
        :error,
        [
          %{"code" => "already_exists", "field" => "name", "resource" => "Label"},
          %{"code" => "invalid", "field" => "color", "resource" => "Label"}
        ]
      }

      assert error_response == Label.add(label, repo1, "access_token", UnSuccessfulLabelTestAPI)
    end

    test "can add a label to multiple repositories", %{repos: repos, label: label} do
      error_response =  {
        :error,
        [
          %{"code" => "already_exists", "field" => "name", "resource" => "Label"},
          %{"code" => "invalid", "field" => "color", "resource" => "Label"}
        ]
      }
      assert [error_response, error_response] == Label.add(label, repos, "access_token", UnSuccessfulLabelTestAPI)
    end
  end
end
