defmodule MobileDelegator.Controller do
  import Plug.Conn

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
end
