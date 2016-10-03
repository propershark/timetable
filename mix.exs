defmodule Timetable.Mixfile do
  use Mix.Project

  def project do
    [app: :timetable,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger],
     mod: {Timetable, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # GTFS wrapper
      {:gtfs, "~> 0.3.1"},
      # WAMP interface
      {:spell, "~> 0.1"},
      # WebSocket transportation
      {:websocket_client, github: "jeremyong/websocket_client", tag: "v0.7"},
      # JSON serialization
      {:poison, "~> 1.4"},
      # Required if using the msgpack serializer:
      # {:msgpax, "~> 0.7"}
    ]
  end
end
