return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', function()
        if vim.bo.filetype ~= 'fugitive' then
          vim.api.nvim_command 'G'
        else
          vim.api.nvim_command ':q'
        end
      end, { desc = 'Git status' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fugitive',
        callback = function(_)
          vim.keymap.set('n', '<leader>gp', function()
            vim.api.nvim_command 'Git push'
          end, { buffer = true, desc = 'Git push' })
        end,
      })
    end,
  },
}
