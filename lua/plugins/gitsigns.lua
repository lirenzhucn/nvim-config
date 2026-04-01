--- @module 'lazy'
--- @type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  enabled = vim.fn.executable 'git' == 1,
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local prefix = '<Leader>h'

      local function map(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'Git: ' .. desc })
      end

      -- map(prefix .. 'l', function()
      --   gitsigns.blame_line()
      -- end, 'View Git blame')
      map(prefix .. 'L', function()
        gitsigns.blame_line { full = true }
      end, 'View full Git blame')
      map(prefix .. 'p', function()
        gitsigns.preview_hunk_inline()
      end, 'Preview Git hunk')
      map(prefix .. 'r', function()
        gitsigns.reset_hunk()
      end, 'Reset Git hunk')
      map(prefix .. 'r', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Reset Git hunk')
      map(prefix .. 'R', function()
        gitsigns.reset_buffer()
      end, 'Reset Git buffer')
      map(prefix .. 's', function()
        gitsigns.stage_hunk()
      end, 'Stage/unstage Git hunk')
      map(prefix .. 's', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Stage/unstage Git hunk')
      map(prefix .. 'S', function()
        gitsigns.stage_buffer()
      end, 'Stage/unstage Git buffer')
      map(prefix .. 'd', function()
        gitsigns.diffthis()
      end, 'View Git diff')

      map(prefix .. '[G', function()
        gitsigns.nav_hunk 'first'
      end, 'First Git hunk')
      map(prefix .. ']G', function()
        gitsigns.nav_hunk 'last'
      end, 'Last Git hunk')
      map(prefix .. '[g', function()
        gitsigns.nav_hunk 'next'
      end, 'Next Git hunk')
      map(prefix .. ']g', function()
        gitsigns.nav_hunk 'prev'
      end, 'Previous Git hunk')

      -- for _, mode in ipairs { 'o', 'x' } do
      --   maps[mode]['ig'] = { ':<C-U>Gitsigns select_hunk<CR>', desc = 'inside Git hunk' }
      -- end
    end,
  },
}
