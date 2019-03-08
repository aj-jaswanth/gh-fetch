defmodule Issues.Cli do
  def main(argv) do
    [user: user, project: project] = parse(argv)
    Github.Issues.list_issues(user, project)
  end

  def parse(argv) do
    {parsedOptions, _, _} =
      OptionParser.parse(argv, [{:switches, [user: :string, projefct: :string]}])

    parsedOptions
  end
end
