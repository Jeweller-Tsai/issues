defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [app: :issues,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     name: "Issues",
     source_url: "https://github.com/Jeweller-Tsai/issues",
     escript: escript_config,
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison, :exjsx]]
  end

  defp deps do
    [
      { :httpoison, "~> 0.5" },
      { :exjsx, "~> 3.0" },
      { :ex_doc, "~> 0.6" },
      { :earmark, ">= 0.0.0" },
    ]
  end

  defp escript_config do
    [main_module: Issues.CLI]
  end
end
