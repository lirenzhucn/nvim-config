---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = { 'lawrence-laz/neotest-zig', version = '^1' },
    opts = function(_, opts)
      if not opts.adapters then
        opts.adapters = {}
      end
      table.insert(opts.adapters, require 'neotest-zig' {})
    end,
  },
  {
    'https://codeberg.org/NTBBloodbath/zig-tools.nvim',
    -- Load zig-tools.nvim only in Zig buffers
    ft = { 'zig' },
    opts = {},
    dependencies = {
      'akinsho/toggleterm.nvim',
      'nvim-lua/plenary.nvim',
    },
  },
}
