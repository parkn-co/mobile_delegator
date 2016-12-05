defmodule MobileDelegator do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: MobileDelegator.Worker.start_link(arg1, arg2, arg3)
      # worker(MobileDelegator.Worker, [arg1, arg2, arg3]),
      worker(__MODULE__, [], function: :run)
    ]

    if Mix.env == :dev do
      IO.puts "Server running at localhost:4000"
    end

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MobileDelegator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    {:ok, _} = Plug.Adapters.Cowboy.http MobileDelegator.Router, []
  end
end
