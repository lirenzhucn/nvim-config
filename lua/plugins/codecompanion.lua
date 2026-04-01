--- @module 'lazy'
--- @type LazySpec
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    -- Custom adapter configuration for Kimi AI CLI integration
    adapters = {
      acp = {
        -- Define a new adapter that extends the existing 'auggie_cli' adapter
        kimi_cli = function()
          -- Extend the base 'auggie_cli' adapter with custom configuration
          return require('codecompanion.adapters').extend('auggie_cli', {
            -- Internal identifier for this adapter
            name = 'kimi_cli',
            -- Display name shown in the UI
            formatted_name = 'Kimi CLI',
            -- Command configuration for executing the AI
            commands = {
              -- Default command to run Kimi AI with ACP (Advanced Code Processing) mode
              default = { 'kimi', '--acp' },
            },
          })
        end,
      },
    },
    strategies = {
      chat = { adapter = 'claude_code' },
      inline = { adapter = 'claude_code' },
      cmd = { adapter = 'claude_code' },
      -- chat = { adapter = 'kimi_cli' },
      -- inline = { adapter = 'kimi_cli' },
      -- cmd = { adapter = 'kimi_cli' },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG',
    },
  },
}
