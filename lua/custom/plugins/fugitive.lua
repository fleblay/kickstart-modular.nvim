-- Git commands and status window
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

vim.keymap.set('n', '<leader>gs', function()
  if vim.bo.filetype ~= 'fugitive' then
    vim.cmd 'G'
  else
    vim.cmd 'q'
  end
end, { desc = 'Toggle [G]it [S]tatus' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitive',
  callback = function()
    vim.keymap.set('n', '<leader>gp', '<Cmd>Git push<CR>', { buffer = true, desc = '[G]it [P]ush' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
