defmodule MobileDelegator.Routers.User do
  use Plug.Router

  def init(opts) do opts end

  plug :match
  plug :dispatch

  alias MobileDelegator.Controllers.User

  post "/signin", do: User.signin conn
  get "/:id", do: User.show conn, %{"id" => id}

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
