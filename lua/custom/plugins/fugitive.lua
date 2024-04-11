return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', function() vim.api.nvim_command("G") end, { desc = "Git status" })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = "fugitive",
        callback = function(_)
          vim.keymap.set('n', '<leader>gp', function() vim.api.nvim_command("Git push") end,
            { buffer = true, desc = "Git push" })
        end
      })
    end,
  },
}
