local function gh(repo) return 'https://github.com/' .. repo end

-- [[ LSP Configuration ]]
--  Language servers are external tools, installed and managed by Mason (`:Mason`).
--  See `:help lsp-config` and `:help lsp-vs-treesitter`

-- Useful status updates for LSP; schemastore provides JSON/YAML schema catalogs for yamlls.
vim.pack.add {
  gh 'j-hui/fidget.nvim',
  gh 'b0o/schemastore.nvim',
}
require('fidget').setup {}

-- This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action; cursor must be on an error or LSP suggestion.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- WARN: This is Goto Declaration, not Definition (e.g. in C this is the header).
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Highlight references of the word under your cursor when it rests there.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints, if the server supports them.
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Language servers to enable. Each key is installed by Mason (via mason-tool-installer)
--  and configured/enabled through `vim.lsp.config`/`vim.lsp.enable` below.
---@type table<string, vim.lsp.Config>
local servers = {
  -- Go
  gopls = {
    cmd_env = { GOFLAGS = '-tags=e2e_tests,integration_tests,e2e,integration' },
    settings = {
      gopls = {
        buildFlags = { '-tags=e2e_tests,integration_tests,e2e,integration' },
      },
    },
  },
  golangci_lint_ls = {},

  -- Shell (picks up shellcheck and shfmt automatically when on PATH)
  bashls = {},

  -- Terraform
  terraformls = {},

  -- Ansible (integrates ansible-lint when on PATH)
  ansiblels = {},

  -- Helm (suppress yamlls noise inside gotmpl-laden templates)
  helm_ls = {
    settings = {
      ['helm-ls'] = {
        yamlls = { diagnosticsLimit = 0 },
      },
    },
  },

  -- YAML: schemastore catalog (kustomization, GitHub workflows, docker-compose, ...)
  --  plus the yamlls built-in kubernetes schema for raw manifests
  yamlls = {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' }, -- disable built-in store; schemastore.nvim provides the catalog
        schemas = vim.tbl_deep_extend('force', require('schemastore').yaml.schemas(), {
          kubernetes = {
            'k8s/**/*.{yml,yaml}',
            'kubernetes/**/*.{yml,yaml}',
            'manifests/**/*.{yml,yaml}',
            'deploy/**/*.{yml,yaml}',
            'base/**/*.{yml,yaml}',
            'overlays/**/*.{yml,yaml}',
          },
        }),
      },
    },
  },

  stylua = {}, -- Used to format Lua code

  -- Special Lua Config, as recommended by neovim help docs
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        completion = { callSnippet = 'Replace' },
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

-- Automatically install LSPs and related tools to stdpath for Neovim (`:Mason` to inspect).
require('mason').setup {}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  -- Formatters and linters used by conform / bashls
  'goimports',
  'gofumpt',
  'golangci-lint',
  'yamlfmt',
  'shellcheck',
  'shfmt',
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- vim: ts=2 sts=2 sw=2 et
