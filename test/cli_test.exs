defmodule CliTest do
  use ExUnit.Case

  test "parses cmd line options" do
    [user: user, project: project] = Issues.Cli.parse(["--user", "github", "--project", "fetch"])
    assert user == "github"
    assert project == "fetch"
  end
end
