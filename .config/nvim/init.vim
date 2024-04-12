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

" " LSP config in Nvim
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Harpoon
Plug 'ThePrimeagen/harpoon'

" Elixir
Plug 'mhanberg/elixir.nvim'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" File tree
Plug 'nvim-neo-tree/neo-tree.nvim'

" Colorscheme
Plug 'sainnhe/everforest'
Plug 'rakr/vim-two-firewatch'

call plug#end()

filetype plugin indent on
syntax on

colorscheme everforest

lua << EOF
  vim.g.material_style = "darker"
EOF

" /==================\
" | General settings |
" \==================/
"
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

  nnoremap <silent> <C-p> :Telescope find_files<CR>
  tnoremap <Esc> <C-\><C-n>
endif

lua << EOF
  vim.api.nvim_set_option("clipboard","unnamed")
EOF


 
" /====================\
" | Elixir LS settings |
" \====================/
lua << EOF
local elixir = require("elixir")
elixir.setup({
  settings = {
    dialyzerEnabled = true,
    fetchDeps = true,
    enableTestLenses = true,
    suggestSpecs = true
  },

  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
    vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
    vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  end
})

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
vim.g['mix_format_on_save'] = 1
vim.g['mix_format_silent_errors'] = 1

local lsp = require('lsp-zero')

lsp.nvim_workspace()
lsp.preset('recommended')
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['elixirls'] = { 'elixir' },
    ['sqlls'] = { 'sql' },
    -- if you have a working setup with null-ls
    -- you can specify filetypes it can format.
    -- ['null-ls'] = {'javascript', 'typescript'},
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

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
EOF

" /=====================\
" | Treesitter settings |
" \=====================/
"
lua << EOF
require'nvim-treesitter.configs'.setup {
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
