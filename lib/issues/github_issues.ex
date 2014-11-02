defmodule Issues.GithubIssues do

  require Logger
  require IEx

  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)|> HTTPoison.get |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %HTTPoison.Response{ status_code: 200, body: body } }) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    { :ok, JSX.decode!(body) }
  end

  def handle_response({ :ok, %HTTPoison.Response{ status_code: status, body: body } }) do
    Logger.error "Error #{status} returned"
    { :error, JSX.decode!(body) }
  end

  def handle_response({ :error, %HTTPoison.Error{ reason: reason } }) do
    Logger.error inspect(reason)
    { :error, reason }
  end
end
