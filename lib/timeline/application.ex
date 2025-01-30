defmodule Timeline.Application do
  use Application

  def start(_type, _args) do
    children = [
      Timeline.Repo,
      {Task, fn -> Timeline.Cache.start_link() end},
      TimelineWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Timeline.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
