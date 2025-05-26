return {
  'rebelot/kanagawa.nvim',
  config = function()
    local set = require('kanagawa').setup {
      -- transparent = true,
      undercurl = false,
      theme = 'wave',
      colors = {
        palette = {},
        theme = {
          wave = {
            ui = {
              -- bg = 'none',
              -- bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- NormalFloat = { bg = 'none' },
          -- FloatBorder = { bg = 'none' },
          -- FloatTitle = { bg = 'none' },
          -- SignColumn = { bg = 'none' },
          -- StatusLineNC = { bg = 'none' },
          -- StatusLine = { bg = 'none' },
          -- TabLine = { bg = 'none' },
          -- TabLineFill = { bg = 'none' },
          -- FoldColumn = { bg = 'none' },
          -- LineNr = { bg = 'none' },
          CursorLineNr = { bg = '#2a2a37' },
        }
      end,
    }
  end,
}
