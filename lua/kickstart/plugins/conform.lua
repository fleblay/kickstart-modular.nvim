local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Formatting ]]
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Autoformat on save EXCEPT for these filetypes.
    -- yaml formats only via explicit <leader>f; helm is never formatted
    -- (yamlfmt would mangle the gotmpl markup).
    local disable_filetypes = { c = true, cpp = true, yaml = true, helm = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
    return { timeout_ms = 1000, lsp_format = 'fallback' }
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters below if configured, otherwise LSP formatting
  },
  formatters_by_ft = {
    go = { 'goimports', 'gofumpt' },
    sh = { 'shfmt' },
    terraform = { 'terraform_fmt' }, -- needs the terraform binary (brew)
    yaml = { 'yamlfmt' }, -- reads ~/.config/yamlfmt/.yamlfmt
    -- lua intentionally absent: stylua runs as an LSP server, reached via lsp_format fallback
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

-- vim: ts=2 sts=2 sw=2 et
