defmodule PostalCodex.Mixfile do
  use Mix.Project

  def project do
    [app: :postal_codex,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:logger, :httpoison, :poison,:cowboy, :plug, :jiffy],
      mod: {PostalCodex, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.4"},
      {:poison, "~>1.1.0"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 0.8.0"},
      {:jiffy, github: "davisp/jiffy"},
      {:exrm, "~> 0.14.11"}
    ]
  end
end
