-- Tabnine plugin

---@module 'lazy'
---@type LazySpec
return {
  'codota/tabnine-nvim',
  name = 'tabnine',
  build = './dl_binaries.sh',
  lazy = false,
  config = function()
    require('tabnine').setup {
      disable_auto_comment = true,
      accept_keymap = '<C-s>',
      dismiss_keymap = '<C-j>',
      debounce_ms = 800,
      suggestion_color = { gui = '#808080', cterm = 244 },
      exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
      log_file_path = nil, -- absolute path to Tabnine log file
    }
  end,
}
