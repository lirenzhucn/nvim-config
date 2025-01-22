-- set up some key bindings for toggle term
vim.keymap.set('n', "<C-'>", '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('t', "<C-'>", '<Cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('i', "<C-'>", '<Esc><Cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
-- C-' doesn't seem to work on macOS (failed in both Ghostty and kitty); use M-' as a backup
vim.keymap.set('n', "<M-'>", '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('t', "<M-'>", '<Cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('i', "<M-'>", '<Esc><Cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

vim.keymap.set('n', '<leader>tf', '<Cmd>ToggleTerm direction=float<CR>', { desc = 'ToggleTerm float' })
vim.keymap.set('n', '<leader>th', '<Cmd>ToggleTerm size=10 direction=horizontal<CR>', { desc = 'ToggleTerm horizontal split' })
vim.keymap.set('n', '<leader>tv', '<Cmd>ToggleTerm size=80 direction=vertical<CR>', { desc = 'ToggleTerm vertical split' })

--- @module 'toggleterm'
--- @module 'lazy'
--- @type LazySpec
return {
  {
    {
      'akinsho/toggleterm.nvim',
      cmd = { 'ToggleTerm', 'TermExec' },
      opts = {
        -- following options are copied from AstroNvim
        highlights = {
          Normal = { link = 'Normal' },
          NormalNC = { link = 'NormalNC' },
          NormalFloat = { link = 'NormalFloat' },
          FloatBorder = { link = 'FloatBorder' },
          StatusLine = { link = 'StatusLine' },
          StatusLineNC = { link = 'StatusLineNC' },
          WinBar = { link = 'WinBar' },
          WinBarNC = { link = 'WinBarNC' },
        },
        size = 10,
        ---@param t Terminal
        on_create = function(t)
          vim.opt_local.foldcolumn = '0'
          vim.opt_local.signcolumn = 'no'
          if t.hidden then
            local function toggle()
              t:toggle()
            end
            vim.keymap.set({ 'n', 't', 'i' }, "<C-'>", toggle, { desc = 'Toggle terminal', buffer = t.bufnr })
            -- C-' doesn't seem to work on macOS (failed in both Ghostty and kitty); use M-' as a backup
            vim.keymap.set({ 'n', 't', 'i' }, "<M-'>", toggle, { desc = 'Toggle terminal', buffer = t.bufnr })
            vim.keymap.set({ 'n', 't', 'i' }, '<F7>', toggle, { desc = 'Toggle terminal', buffer = t.bufnr })
          end
        end,
        shading_factor = 2,
        float_opts = { border = 'rounded' },
      },
    },
  },
}
