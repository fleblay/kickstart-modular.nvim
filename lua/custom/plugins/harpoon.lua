return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Add current buffer to Harpoon' })
      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Jump to Harpoon 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Jump to Harpoon 2' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Jump to Harpoon 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Jump to Harpoon 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Jump to Harpoon 4' })
      vim.keymap.set('n', '<leader>p', function()
        harpoon:list():prev()
      end, { desc = 'Jump to next Harpoon buffer' })
      vim.keymap.set('n', '<leader>n', function()
        harpoon:list():next()
      end, { desc = 'Jump to previous Harpoon buffer' })
      vim.keymap.set('n', '<leader>e', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open Harpoon window' })
    end,
  },
}
