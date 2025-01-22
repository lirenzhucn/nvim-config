# Liren's Neovim Config

## TL;DR

This is my personal neovim config. My primary use case is software development
using languages like Python, Rust, C++, Zig, etc. My other use cases include
Markdown note-taking with Obsidian, [plain text
accounting](https://plantextaccounting.org) workflows using ledger-like tools
(currently using [hledger](https://hledger.org)), and cloud admin.

[which-key.nvim](https://github.com/folke/which-key.nvim) is used to provide
hints for key bindings. `<space>fk` is also bound to launch a telescope window
to (fuzzy) search for keymaps.

A significant portion of this config is derived or inspired by
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and
[TJ DeVries's Neovim Config](https://github.com/tjdevries/config.nvim). But many
modifications have been made as well. I also borrowed some ideas from
[AstroCommunity](https://github.com/AstroNvim/astrocommunity), especially for
language-specific "packs".

## Some Notable Choices

- Uses lazy as the package manager
- Uses Neovim's builtin LSP client
- For completion, uses `<C-y>` to accept, `<C-n>` to go to next and `<C-p>` to
  go to previous; **tab and enter don't work**
- Uses [ressession.nvim](https://github.com/stevearc/resession.nvim) for session
  management (instead of anything that uses the builtin `:mksession`)
- Uses [blink.cmp](https://github.com/Saghen/blink.cmp) as the completion
  engine (instead of nvim-cmp)
- Uses [conform.nvim](https://github.com/stevearc/conform.nvim) to manage
  formating (instead of null-ls)
- Has some snippets set up using [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  (see `snippets/`)
- Includes TJ's "multi-ripgrep" telescope customization (see
  `lua/custom/telescope/multi-ripgrep.lua`)

## Config Organization

Ths configuration is organized in a typical lazy-based layout.

- The main setup of lazy is done in `lua/lazy-setup.lua`
- Individual plugins or plugin groups are placed under `lua/plugins/`
- Under `lua/custom/` are customizations that aren't simply configurations of
  plugins (e.g. the multi-ripgrep tool)
- Under `after/ftplugin/` are simple filetype customizations (e.g. set
  `vim.o.<option>` for a particular filetype)
- Under `snippets/` are snippets loaded by LuaSnip, including VSCode compatible
  ones and lua ones

## LSP, DAP, and Other Coding Stuff

Unlike distros like AstroNvim, I went with a "quick-and-dirty" approach when it
came with setting up LSP stuff. It is centralized in `lua/plugins/lsp.lua`
instead of being modular per language. The general tech stack is similar to that
of AstroNvim, which uses mason-lspconfig.nvim together with lspconfig.nvim to
set up both the Neovim builtin LSP client and Mason.

A similar approach is taken for DAP. Everything is under `lua/plugins/dap.lua`.
With DAP, the adapters are defined in this file, but configurations are defined
in individual projects using the `launch.json` and `tasks.json` approach used by
VSCode. For more info, check out VSCode's documentation as well as
`:help dap-launch.json` in Neovim doc.
