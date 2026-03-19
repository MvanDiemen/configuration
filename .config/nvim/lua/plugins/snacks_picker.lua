return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        -- your picker configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    keys = {
      { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    }
  }
}
