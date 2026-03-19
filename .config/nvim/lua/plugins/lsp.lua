return {
  { "neovim/nvim-lspconfig" },
  {
    "elixir-tools/elixir-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- 1. DEFINE CONFIGS MANUALLY (Since the lsp/ folder is being ignored)
      local elixirls_cmd = "/home/michael/.vscode/extensions/jakebecker.elixir-ls-0.30.0/elixir-ls-release/language_server.sh"
      local expert_cmd = "/home/michael/Repos/expert/expert_linux_amd64"

      -- Configure ElixirLS
      vim.lsp.config("elixirls", {
        cmd = { elixirls_cmd },
        root_markers = { "mix.exs", ".git" },
        settings = {
          elixirLS = { dialyzerEnabled = true, fetchDeps = true }
        }
      })

      -- Configure Expert
      vim.lsp.config("expert", {
        cmd = { expert_cmd },
        root_markers = { "mix.exs", ".git" },
        filetypes = { "elixir", "heex" },
      })

      -- 2. ENABLE THEM
      vim.lsp.enable("elixirls")
      vim.lsp.enable("expert")

      -- 3. ELIXIR-TOOLS (Extras only)
      require("elixir").setup({
        elixirls = { enable = false },
        nextls = { enable = false },
        projectionist = { enable = true },
      })

      -- 4. THE FORMATTER TRIGGER (Inside LspAttach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          
          -- Keymaps
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- Create the format-on-save autocmd ONLY for this buffer
          if client and client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ id = client.id, async = false, timeout_ms = 5000 })
              end,
            })
          end
        end,
      })
    end,
  },
}
