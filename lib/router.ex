defmodule MobileDelegator.Router do
  use Plug.Router
  alias MobileDelegator.Routers

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Logger, log: :debug
  plug Plug.Parsers, parsers: [:json, :urlencoded, :multipart],
                     json_decoder: Poison
  plug :match
  plug :dispatch

  forward "/users", to: Routers.User

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
