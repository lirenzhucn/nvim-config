--- @module 'lazy'
--- @type LazySpec
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin-mocha'
    -- end,
  },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    -- priority = 1000,
    -- init = function()
    --   -- vim.cmd.colorscheme 'lackluster'
    --   -- vim.cmd.colorscheme 'lackluster-hack' -- my favorite
    --   vim.cmd.colorscheme 'lackluster-mint'
    -- end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    init = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },
}
