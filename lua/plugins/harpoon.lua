--- @module 'lazy'
--- @type LazySpec
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<Leader>hm', function()
      harpoon:list():add()
    end, { desc = '[M]ark the current file' })
    vim.keymap.set('n', '<Leader>hl', '<Cmd>Telescope harpoon marks<cr>', { desc = '[L]ist harpoon marks in Telescope' })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<Leader>h%d', idx), function()
        harpoon:list():select(idx)
      end)
    end

    -- let's also add harpoon's telescope extension
    local telescope = require 'telescope'
    if telescope ~= nil then
      telescope.load_extension 'harpoon'
    end
  end,
}
