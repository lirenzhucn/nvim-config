-- config modified from astrocommunity.completion.blink-cmp

---@type function?
local icon_provider

local function get_icon(CTX)
  if not icon_provider then
    local base = function(ctx)
      ctx.kind_hl_group = 'BlinkCmpKind' .. ctx.kind
    end
    local _, mini_icons = pcall(require, 'mini.icons')
    if _G.MiniIcons then
      icon_provider = function(ctx)
        base(ctx)
        if ctx.item.source_name == 'LSP' then
          local item_doc, color_item = ctx.item.documentation, nil
          if item_doc then
            local highlight_colors_avail, highlight_colors = pcall(require, 'nvim-highlight-colors')
            color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
          end
          local icon, hl = mini_icons.get('lsp', ctx.kind or '')
          if icon then
            ctx.kind_icon = icon
            ctx.kind_hl_group = hl
          end
          if color_item and color_item.abbr and color_item.abbr_hl_group then
            ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
          end
        elseif ctx.item.source_name == 'Path' then
          ctx.kind_icon, ctx.kind_hl_group = mini_icons.get(ctx.kind == 'Folder' and 'directory' or 'file', ctx.label)
        end
      end
    end
    local lspkind_avail, lspkind = pcall(require, 'lspkind')
    if lspkind_avail then
      icon_provider = function(ctx)
        base(ctx)
        if ctx.item.source_name == 'LSP' then
          local item_doc, color_item = ctx.item.documentation, nil
          if item_doc then
            local highlight_colors_avail, highlight_colors = pcall(require, 'nvim-highlight-colors')
            color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
          end
          local icon = lspkind.symbolic(ctx.kind, { mode = 'symbol' })
          if icon then
            ctx.kind_icon = icon
          end
          if color_item and color_item.abbr and color_item.abbr_hl_group then
            ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
          end
        end
      end
    end
    icon_provider = base
  end
  icon_provider(CTX)
end

--- @module 'lazy'
--- @type LazySpec
return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets', { 'saghen/blink.compat', lazy = true, version = false } },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },

      completion = {
        list = {
          selection = {
            auto_insert = function(ctx)
              return ctx.mode == 'cmdline'
            end,
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
          },
        },
        menu = {
          auto_show = true,
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  get_icon(ctx)
                  return ctx.kind_icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  get_icon(ctx)
                  return ctx.kind_hl_group
                end,
              },
            },
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
          },
        },
      },

      signature = {
        window = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      snippets = {
        preset = 'luasnip',
        -- This comes from the luasnip extra, if you don't add it, won't be able to
        -- jump forward or backward in luasnip snippets
        -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
    },
    opts_extend = { 'sources.default', 'sources.cmdline' },
    event = { 'InsertEnter', 'CmdlineEnter' },
  },
}
