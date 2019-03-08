defmodule Github.Issues do
  @github_url Application.get_env(:issues, :url)

  def fetch(user, project) do
    url(user, project)
    |> HTTPoison.get()
    |> response
  end

  def list_issues(user, project) do
    fetch(user, project) |> sort |> Enum.take(5) |> Enum.each(&print(&1))
  end

  def print(%{"created_at" => created_at, "number" => number}) do
    IO.puts("#{created_at} #{number}")
  end

  def url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def response({:ok, %{status_code: 200, body: body}}) do
    {:ok, 200, Poison.decode!(body)}
  end

  def response({:ok, %{status_code: status_code, body: body}}) do
    {:error, status_code, Poison.decode!(body)}
  end

  def sort({:ok, _, issues}) do
    Enum.sort(issues, &(&1["created_at"] <= &2["created_at"]))
  end
end
