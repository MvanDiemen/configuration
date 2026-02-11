" ============================================================================
" VIM CONFIGURATION FILE
"
" Author:  Michaël van Diemen
" License: Public Domain
"
filetype off

call plug#begin('~/.local/share/nvim/plugged')

" Telescope https://github.com/nvim-telescope/telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

" LSP-zero https://github.com/VonHeikemen/lsp-zero.nvim
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

" LSP config in Nvim
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Elixir LS
Plug 'elixir-tools/elixir-tools.nvim'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plugins
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-easy-align'
Plug 'ThePrimeagen/harpoon'
Plug 'APZelos/blamer.nvim'
Plug 'folke/trouble.nvim'
Plug 'crispgm/nvim-tabline'
Plug 'numToStr/Comment.nvim'
Plug 'kwkarlwang/bufresize.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'BurntSushi/ripgrep'

" Colorscheme
Plug 'sainnhe/everforest'
Plug 'rakr/vim-two-firewatch'
Plug 'catppuccin/nvim'


call plug#end()

filetype plugin indent on
syntax on

colorscheme catppuccin-mocha

lua << EOF
  vim.o.splitright = true
  vim.g.material_style = "darker"
  vim.g.blamer_enabled = true
  require('Comment').setup()
  require("bufresize").setup()
  require("ibl").setup()
  require('tabline').setup({
    show_index = true,           -- show tab index
    show_modify = true,          -- show buffer modification indicator
    show_icon = false,           -- show file extension icon
    fnamemodify = ':t',          -- file name modifier
    modify_indicator = '[+]',    -- modify indicator
    no_name = 'No name',         -- no name buffer name
    brackets = { '', '' },     -- file name brackets surrounding
    inactive_tab_max_length = 0  -- max length of inactive tab titles, 0 to ignore
  })
EOF

" /==================\
" | General settings |
" \==================/
"
set showtabline=2
set number
set termguicolors
set shell=fish
set nolazyredraw
set showcmd
set hid
set clipboard+=unnamedplus
set mouse=a
set history=100
set nocursorcolumn
set nocursorline
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set tw=120
set wrap linebreak
set autoread

set signcolumn=yes  " Git Gutter settings

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  " nnoremap <silent> <C-p> :Telescope find_files<CR>
  " tnoremap <Esc> <C-\><C-n>
endif

" Key bindings
lua << EOF
  vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
  vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
  vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
  vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
  vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
  vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {})
  vim.api.nvim_create_user_command("WQ", "wq", {})
  vim.api.nvim_create_user_command("Wq", "wq", {})
  vim.api.nvim_create_user_command("W", "w", {})
  vim.api.nvim_create_user_command("Q", "q", {})
EOF

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Setup RipGrep search
" nnoremap \s :Rg -g '!.git'<SPACE>

lua << EOF
  vim.api.nvim_set_option("clipboard","unnamed")
EOF

" /====================\
" | Elixir LS settings |
" \====================/

" NOTE: Figure this out
lua << EOF
vim.lsp.config('expert', {
  cmd = { '/home/michael/Repos/expert/expert_linux_amd64' },
  root_markers = { 'mix.exs', '.git' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
})

-- vim.lsp.enable('expert')

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     buffer = buffer,
--     callback = function()
--         vim.lsp.buf.format { async = false }
--     end
-- })
EOF
lua << EOF
  local lsp = require('lsp-zero')
  lsp.extend_lspconfig()

  lsp.on_attach(function(client, bufnr)
    -- whatever
    lsp.default_keymaps({buffer = bufnr})
  end)

  vim.lsp.set_log_level("off")
  local elixir = require("elixir")
  local elixirls = require("elixir.elixirls")

  vim.lsp.config['elixirls'] = {
    filetypes = {"elixir", "eelixir", "heex", "surface", "eex"},
    cmd = {"/home/michael/.vscode/extensions/jakebecker.elixir-ls-0.30.0/elixir-ls-release/language_server.sh"},
    settings = {
      dialyzerEnabled = true,
      mixEnv = "test",
      fetchDeps = true,
    },
  }
  vim.lsp.enable('elixirls')
  --
  -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  -- vim.g['mix_format_on_save'] = 1
  -- vim.g['mix_format_silent_errors'] = 1
  --
  lsp.format_on_save({
    format_opts = {
      async = false,
      timeout_ms = 3000,
    },
    servers = {
      ['elixirls'] = { 'elixir' }
    }
  })

  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  })

  lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })


  lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end)
EOF

" /==================\
" | HTML LS settings |
" \==================/

lua << EOF
vim.lsp.config('html', {})
EOF

" /===================\
" | Gitsigns settings |
" \===================/

lua << EOF
  require('gitsigns').setup{
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    }
  }
EOF

" /====================\
" | Telescope settings |
" \====================/
lua << EOF
  local telescope = require('telescope')

  -- telescope.setup{
  --   defaults = {
  --     vimgrep_arguments = {
  --       'rg',
  --       '--smart-case',
  --       '-u',
  --       '-g="!**/.git/*"', 
  --       '-g="!**/_build/*"', 
  --       '-g="!**/.elixirls/*"', 
  --       '-g="!**/deps/*"'
  --     }
  --   }
  -- }

  -- local config  = require('telescope.config').values
  -- config.vimgrep_arguments = {
  --   'rg',
  --   '--smart-case',
  --   '-g=!.git'
  --   }
  --
  local builtin = require('telescope.builtin')
  vim.keymap.set("n", "<C-p>", builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>ff',builtin.find_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
EOF

" /=====================\
" | Treesitter settings |
" \=====================/
"
lua << EOF
  require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "html", "css", "javascript", "eex", "surface", "erlang", "heex"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
  }
EOF
