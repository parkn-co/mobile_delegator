defmodule MobileDelegator.Controllers.User do
  import MobileDelegator.Controller

  @api "http://35.161.51.205:3000/api/v1"

  def signin(conn) do
    {status, body} = post(@api, ["auth", "signin"], conn.body_params)

    send conn, status, body
  end
end
