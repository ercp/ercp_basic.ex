defmodule ERCPBasic.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/ercp/ercp_basic.ex"

  def project do
    [
      app: :ercp_basic,
      version: @version <> dev(),
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Tools
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: cli_env(),

      # Docs
      docs: [
        main: "ERCPBasic",
        source_url: @repo_url,
        source_ref: "v#{@version}"
      ],

      # Package
      package: package(),
      description: "An implementation of ERCP Basic in Elixir."
    ]
  end

  def application do
    [
      mod: {ERCPBasic.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # Development dependencies
      {:credo, "~> 1.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0-rc", only: :dev, runtime: false},
      {:excoveralls, ">= 0.0.0", only: :test, runtime: false},
      {:mix_test_watch, ">= 0.0.0", only: :test, runtime: false},
      {:ex_unit_notifier, ">= 0.0.0", only: :test, runtime: false},
      {:stream_data, "~> 0.4.0", only: :test},

      # Project dependencies

      # Documentation dependencies
      {:ex_doc, "~> 0.19", only: :docs, runtime: false}
    ]
  end

  # Dialyzer configuration
  defp dialyzer do
    [
      # Use a custom PLT directory for continuous integration caching.
      plt_core_path: System.get_env("PLT_DIR"),
      plt_file: plt_file(),
      plt_add_deps: :transitive,
      flags: [
        :unmatched_returns,
        :error_handling,
        :race_conditions
      ],
      ignore_warnings: ".dialyzer_ignore"
    ]
  end

  defp plt_file do
    case System.get_env("PLT_DIR") do
      nil -> nil
      plt_dir -> {:no_warn, Path.join(plt_dir, "ercp_basic.plt")}
    end
  end

  defp cli_env do
    [
      # Run mix test.watch in `:test` env.
      "test.watch": :test,

      # Always run Coveralls Mix tasks in `:test` env.
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.html": :test,

      # Use a custom env for docs.
      docs: :docs
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  # Helper to add a development revision to the version. Do NOT make a call to
  # Git this way in a production release!!
  def dev do
    with {rev, 0} <-
           System.cmd("git", ["rev-parse", "--short", "HEAD"],
             stderr_to_stdout: true
           ) do
      "-dev+" <> String.trim(rev)
    else
      _ -> "-dev"
    end
  end
end
