import Config

config :timeline, Timeline.Repo,
  database: "timeline_dev",
  username: "jason",
  password:
    "zFbGbDa.rtxZ-JMjHVGFFXhVde2x8D8eCoCRaUkBCA-yNZTGrbWrU-dK!E7u7zs7qshgk!43!9q@@qsuZosa9GroCjg2VoEMpn62",
  hostname: "localhost"

config :timeline, ecto_repos: [Timeline.Repo]
