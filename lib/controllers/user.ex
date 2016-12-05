defmodule MobileDelegator.Controllers.User do
  import MobileDelegator.Controller

  def index(conn) do
    send conn, :ok, "Hello, User Controller!"
  end

  def show(conn, _params) do
    case req("") do
      {:ok, body} -> send conn, :ok, body
      {:error, _body} -> send conn, :error, "not found"
    end
  end

  defp req(path) do
    %HTTPoison.Response{
      body: body,
      status_code: status_code
    } = HTTPoison.get! "35.161.51.205:3000/api/v1/#{path}"

    {status(status_code), body}
  end
end
