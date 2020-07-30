defmodule LeenwoElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: LeenwoElixir.Worker.start_link(arg)
      # {LeenwoElixir.Worker, arg}
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: LeenwoElixir.Endpoint,
        options: [port: 4001]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LeenwoElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
