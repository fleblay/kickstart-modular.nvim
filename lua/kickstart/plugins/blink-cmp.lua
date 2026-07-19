local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Snippet Engine ]]
vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Premade snippets for many languages/frameworks
vim.pack.add { gh 'rafamadriz/friendly-snippets' }
require('luasnip.loaders.from_vscode').lazy_load()

-- [[ Autocomplete Engine ]]
vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = {
    -- 'enter': <cr> accepts; <c-n>/<c-p> select; <c-space> opens menu/docs; <c-e> hides.
    -- See `:help blink-cmp-config-keymap`
    preset = 'enter',
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = 'mono',
  },

  completion = {
    -- Press `<c-space>` to show documentation; set auto_show = true to show it after a delay.
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  snippets = { preset = 'luasnip' },

  -- Lua fuzzy matcher (no build step); 'prefer_rust_with_warning' downloads a prebuilt binary.
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}

-- vim: ts=2 sts=2 sw=2 et
