return {
  -- USE THE FULL PATH HERE
  cmd = { "/home/michael/.vscode/extensions/jakebecker.elixir-ls-0.30.0/elixir-ls-release/language_server.sh" },
  root_markers = { "mix.exs", ".git" },
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = true,
    }
  }
}
