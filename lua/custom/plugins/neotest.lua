return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'fredrikaverpil/neotest-golang', version = '*' }, -- Installation
    },
    config = function()
      local neotest = require 'neotest'
      neotest.setup {
        adapters = {
          require 'neotest-golang' {
            go_test_args = { '-count=1', '-tags=e2e_tests integration_tests e2e integration' },
            go_list_args = { '-tags=integration' },
            dap_go_opts = {
              delve = {
                build_flags = { '-tags=integration' },
              },
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>rt', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = '[R]un [T]ests for [F]ile' })
      vim.keymap.set('n', '<leader>rf', function()
        neotest.run.run()
      end, { desc = '[R]un [F]ollowing Test' })
      vim.keymap.set('n', '<leader>ro', function()
        neotest.output.open { enter = true, auto_close = true }
      end, { desc = '[O]pen Test window' })
      vim.keymap.set('n', '<leader>rO', function()
        neotest.output_panel.toggle()
      end, { desc = 't[O]ggle Test window' })
    end,
  },
}
