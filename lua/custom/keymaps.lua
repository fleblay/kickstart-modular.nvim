-- Remove s as it is the same as 'cl'
vim.keymap.set('n', 's', '<Nop>')

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Quickfix list navigation
vim.keymap.set('n', 'sqn', function()
  vim.cmd 'cn'
end, { desc = 'Go to next quickfix list item' })

vim.keymap.set('n', 'sqp', function()
  vim.cmd 'cp'
end, { desc = 'Go to previous quickfix list item' })

vim.keymap.set('n', 'sqg', function()
  vim.cmd '.cc'
end, { desc = 'Go to current quickfix list item' })

vim.keymap.set('n', 'sqo', function()
  vim.cmd 'copen'
end, { desc = 'Open quickfix list' })
vim.keymap.set('n', 'sqc', function()
  vim.cmd 'cclose'
end, { desc = 'Close quickfix list' })

--
vim.keymap.set('n', 'sw', function()
  vim.cmd 'wa'
end, { desc = 'Write all files' })
