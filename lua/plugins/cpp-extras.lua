--- This is my C++ related setup, inspired by AstroNVim Community

-- register an autocmd to load 'clangd_extensions' when clangd is attached
-- and set a few key maps as well.
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Load clangd_extensions with clangd',
  group = vim.api.nvim_create_augroup('clangd-extensions-on-attach', { clear = true }),
  callback = function(args)
    if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == 'clangd' then
      require 'clangd_extensions'
      vim.keymap.set('n', '<Leader>lw', '<Cmd>ClangdSwitchSourceHeader<CR>', { desc = '[L]SP S[w]itch source/header file' })
      vim.keymap.set('n', '<Leader>lt', '<Cmd>ClangdToggleInlayHints<CR>', { desc = '[L]SP [T]oggle inlay hints' })
    end
  end,
})

---@module 'lazy'
---@type LazySpec
return {
  {
    'p00f/clangd_extensions.nvim',
    lazy = true,
  },
  {
    'Civitasv/cmake-tools.nvim',
    ft = { 'c', 'cpp', 'cuda', 'proto' },
    dependencies = {
      {
        'jay-babu/mason-nvim-dap.nvim',
      },
    },
    opts = {},
  },
}
