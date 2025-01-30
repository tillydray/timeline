import Config

config :timeline, Timeline.Repo,
  database: "timeline_dev",
  username: "jason",
  password:
    "zFbGbDa.rtxZ-JMjHVGFFXhVde2x8D8eCoCRaUkBCA-yNZTGrbWrU-dK!E7u7zs7qshgk!43!9q@@qsuZosa9GroCjg2VoEMpn62",
  hostname: "localhost"

config :timeline, TimelineWeb.Endpoint,
  url: [host: "localhost"],
  http: [ip: {127, 0, 0, 1}, port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  secret_key_base: "3JJU3po+wyNF9v7Xe1BALDUz/W5hdFN6RlOTrwnXRl7LAnAzulxcJGuBzD9vKqsR",
  render_errors: [view: TimelineWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Timeline.PubSub,
  live_view: [signing_salt: "another_secret_salt"]

config :timeline, ecto_repos: [Timeline.Repo]

config :phoenix, :json_library, Jason

config :logger, level: :info
