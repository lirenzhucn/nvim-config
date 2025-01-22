--- @module 'lazy'
--- @type LazySpec
return {
  'stevearc/resession.nvim',
  version = '*',
  config = function(opts)
    vim.api.nvim_create_autocmd('VimLeavePre', {
      desc = 'Save session on close',
      group = vim.api.nvim_create_augroup('resession-auto-save', { clear = true }),
      callback = function()
        local save = require('resession').save
        -- save the current session as the "Last Session"
        save('Last Session', { notify = false })
        -- also as the current working directory inside "dirsession"
        save(vim.fn.getcwd(), { dir = 'dirsession', notify = false })
      end,
    })

    if pcall(require, 'which-key') then
      local which_key = require 'which-key'
      which_key.add { '<Leader>S', group = '[S]ession Manager', mode = 'n' }
    end
    vim.keymap.set('n', '<Leader>Sl', function()
      require('resession').load 'Last Session'
    end, { desc = 'Load last session' })
    vim.keymap.set('n', '<Leader>Ss', require('resession').save, { desc = 'Save this session' })
    vim.keymap.set('n', '<Leader>SS', function()
      require('resession').save(vim.fn.getcwd(), { dir = 'dirsession' })
    end, { desc = 'Save this dirsession' })
    vim.keymap.set('n', '<Leader>Sd', require('resession').delete, { desc = 'Delete a session' })
    vim.keymap.set('n', '<Leader>SD', function()
      require('resession').delete(nil, { dir = 'dirsession' })
    end, { desc = 'Delete a dirsession' })
    vim.keymap.set('n', '<Leader>Sf', require('resession').load, { desc = 'Load a session' })
    vim.keymap.set('n', '<Leader>SF', function()
      require('resession').load(nil, { dir = 'dirsession' })
    end, { desc = 'Load a dirsession' })
    vim.keymap.set('n', '<Leader>S.', function()
      require('resession').load(vim.fn.getcwd(), { dir = 'dirsession' })
    end, { desc = 'Load current dirsession' })

    require('resession').setup(opts)
  end,
  opts = {},
}
