defmodule GithubIssuesTest do
  use ExUnit.Case

  test "error when fetching for a non existent project" do
    {:error, status_code, _} = Github.Issues.fetch("github", "blahblah")
    assert status_code == 404
  end

  test "fetches issues list successfully for valid project" do
    {:ok, status_code, body} = Github.Issues.fetch("github", "fetch")
    assert status_code == 200
    assert Enum.count(body) > 0
  end
end
