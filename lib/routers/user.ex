defmodule MobileDelegator.Routers.User do
  use Plug.Router

  def init(opts) do opts end

  plug :match
  plug :dispatch

  alias MobileDelegator.Controllers.User

  get "/", do: User.index conn
  get "/:id", do: User.show conn, %{"id" => id}
end
