return {
  {
    'rmagatti/auto-session',
    dependencies = {"nvim-tree/nvim-tree.lua"},
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
      --fix for nvim-tree
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = 'NvimTree*',
        callback = function()
          local api = require('nvim-tree.api')
          local view = require('nvim-tree.view')

          if not view.is_visible() then
            api.tree.open()
          end
        end,
      })
    end,
  }
}
