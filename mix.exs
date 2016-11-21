defmodule Cibolsa.Mixfile do
  use Mix.Project

  def project do
    [app: :cibolsa,
     version: "0.0.1",
     elixir: "~> 1.1-dev",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [
      :logger,
      :httpoison,
      :hound,
      :postgrex,
      :ecto],
     mod: {Cibolsa, []}]
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
      {:httpoison, "~> 0.5"},
      {:floki, "~> 0.3"},
      {:hound, "~> 0.8" },
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 1.1"}
    ]
  end
end
