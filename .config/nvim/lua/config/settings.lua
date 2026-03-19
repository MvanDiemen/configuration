vim.api.nvim_set_option("clipboard","unnamed")
vim.o.splitright = true
vim.g.material_style = "darker"
vim.g.blamer_enabled = true
vim.opt.showtabline=2
vim.opt.number=true
vim.opt.termguicolors=true
vim.opt.shell=fish
vim.opt.lazyredraw=false
vim.opt.showcmd=true
vim.opt.hid=true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse=a
vim.opt.history=100
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.expandtab = true
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.tw=120
vim.opt.wrap=linebreak
vim.opt.autoread=true

vim.opt.signcolumn=yes  -- Git Gutter settings


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
