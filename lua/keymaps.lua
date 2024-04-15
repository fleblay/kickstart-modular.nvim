-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--FRED
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', 'sa', function()
  vim.cmd 'b#'
end, { desc = 'Go to Buffer [A]lternate buffer' })
vim.keymap.set('n', 'sd', function()
  vim.cmd 'bn'
  vim.cmd 'bdelete#'
end, { desc = 'Buffer [D]elete' })
vim.keymap.set('n', 'sn', function()
  vim.cmd 'bn'
end, { desc = 'Go to next buffer' })
vim.keymap.set('n', 'sp', function()
  vim.cmd 'bp'
end, { desc = 'Go to previous buffer' })
vim.keymap.set('n', 'scn', function()
  vim.cmd 'cn'
end, { desc = 'Go to next quickfix list item' })
vim.keymap.set('n', 'scp', function()
  vim.cmd 'cp'
end, { desc = 'Go to previous quickfix list item' })
vim.keymap.set('n', 'scg', function()
  vim.cmd '.cc'
end, { desc = 'Open current quickfix list item' })
vim.keymap.set('n', 'sco', function()
  vim.cmd 'copen'
end, { desc = 'Open quickfix list' })
vim.keymap.set('n', 'scc', function()
  vim.cmd 'cclose'
end, { desc = 'Close quickfix list' })

vim.keymap.set('n', 'sw', function()
  vim.cmd 'wa'
end, { desc = 'Write all files' })
-- vim: ts=2 sts=2 sw=2 et
