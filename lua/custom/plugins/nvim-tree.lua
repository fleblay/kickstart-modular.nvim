return {
  {
    --install font from https://www.nerdfonts.com/font-downloads
    --IBMPlexMono
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>tt", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle Tree" },
      { "<leader>tf", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Tree" },
      --USEFULL :
      --P Parent directory
      --< Previous sibling
      --> Next sibling
      --C-] CD
      --o open
    },
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true
      require("nvim-tree").setup()
    end
  }
}
