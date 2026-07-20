local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Configure Treesitter ]]
--  Used to highlight, edit, and navigate code
--  See `:help nvim-treesitter-intro`

vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

-- Ensure these parsers are installed (others auto-install on first use below)
local parsers = {
  -- stock
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  -- devops
  'go',
  'gomod',
  'gosum',
  'proto',
  'dockerfile',
  'json',
  'yaml',
  'gotmpl',
  'helm',
  'terraform',
  'hcl',
}
require('nvim-treesitter').install(parsers)

-- Helm/gotmpl filetypes (no built-in detection in Nvim 0.12)
vim.filetype.add {
  extension = { gotmpl = 'gotmpl' },
  pattern = {
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['helmfile.*%.ya?ml'] = 'helm',
  },
}

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- The buffer may be gone by the time an async parser install finishes
  if not vim.api.nvim_buf_is_valid(buf) then return end
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then return end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Apply window/buffer options to the triggering buffer, not whatever is current
  vim.api.nvim_buf_call(buf, function()
    -- Enable treesitter based folds (foldlevel in options.lua keeps them open)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'

    -- Enable treesitter based indentation when an indent query exists
    -- (otherwise indentexpr falls back to vim's built-in one)
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end)
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is already installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
      require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
  end,
})

-- Expose the parser list so setup.sh can install them headlessly
return { parsers = parsers }

-- vim: ts=2 sts=2 sw=2 et
