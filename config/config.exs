import Config

config :timeline, Timeline.Repo,
  database: "timeline_dev",
  username: "jason",
  password:
    "zFbGbDa.rtxZ-JMjHVGFFXhVde2x8D8eCoCRaUkBCA-yNZTGrbWrU-dK!E7u7zs7qshgk!43!9q@@qsuZosa9GroCjg2VoEMpn62",
  hostname: "localhost"

config :timeline, TimelineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a_very_secret_key",
  render_errors: [view: TimelineWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Timeline.PubSub,
  live_view: [signing_salt: "another_secret_salt"]

config :timeline, ecto_repos: [Timeline.Repo]

config :phoenix, :json_library, Jason
