defmodule ERCPBasic.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # ERCPBasic.Worker1,
      # {ERCPBasic.Worker2, arg},
    ]

    opts = [strategy: :one_for_one, name: ERCPBasic.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
