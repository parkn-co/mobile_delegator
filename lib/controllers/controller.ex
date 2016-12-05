defmodule MobileDelegator.Controller do
  import Plug.Conn

  @headers [{"Content-Type", "application/x-www-form-urlencoded"}]

  def send(conn, status, body) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(Plug.Conn.Status.code(status), Poison.encode!(body))
  end

  def status(code) do
    cond do
      code >= 200 && code < 300 -> :ok
      code >= 300 -> :error
    end
  end

  def get(api, path_info) do
    %HTTPoison.Response{
      body: body,
      status_code: status_code
    } = HTTPoison.get! describe_endpoint(api, path_info)

    {status(status_code), body}
  end

  def post(api, path_info, data) do
    form = URI.encode_query(data)

    %HTTPoison.Response{
      body: body,
      status_code: status_code
    } = HTTPoison.post! describe_endpoint(api, path_info), form, @headers

    {status_code, Poison.decode!(body)}
  end

  defp describe_endpoint(api, path_info) do
    path = Enum.reduce(path_info, "", fn (x, acc) -> "#{acc}#{x}/" end)
    IO.puts "#{api}/#{path}"
    "#{api}/#{path}"
  end
end
