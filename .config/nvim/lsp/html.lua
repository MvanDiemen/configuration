return {
  -- If you have vscode-html-language-server installed globally:
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
}
