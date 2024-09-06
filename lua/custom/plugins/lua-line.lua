return {
  {
    -- Set lualine as statusline
    -- See `:help lualine.txt`
    'nvim-lualine/lualine.nvim',
    dependencies = 'someone-stole-my-name/yaml-companion.nvim',
    config = function()
      local function get_schema()
        local schema = require('yaml-companion').get_buf_schema(0)
        if schema.result[1].name == 'none' then
          return ''
        end
        return schema.result[1].name
      end

      require('lualine').setup {
        opts = {
          options = {
            icons_enabled = false,
            theme = 'auto',
            component_separators = '|',
            section_separators = '',
          },
        },
        sections = {
          lualine_x = { 'encoding', 'fileformat', 'filetype', get_schema() },
        },
      }
    end,
  },
}
