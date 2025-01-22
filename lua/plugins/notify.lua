--- @module 'lazy'
--- @type LazySpec
return {
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
    end,
  },
}
