defmodule MobileDelegator.Router do
  use Plug.Router
  alias MobileDelegator.Routers

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  forward "/users", to: Routers.User
end
