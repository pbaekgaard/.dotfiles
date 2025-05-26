return {
  'Shatur/neovim-ayu',
  config = function()
    require('ayu').setup {
      overrides = {
        Normal = { bg = 'None' },
        NormalFloat = { bg = 'none' },
        ColorColumn = { bg = 'None' },
        SignColumn = { bg = 'None' },
        Folded = { bg = 'None' },
        FoldColumn = { bg = 'None' },
        CursorLine = { bg = 'None' },
        CursorLineNr = { bg = 'None' },
        LineNr = { bg = 'None', fg = '#B8CC52' },
        CursorColumn = { bg = 'None' },
        VertSplit = { bg = 'None' },
        TabLine = { bg = 'None', fg = 'None' },
        TabLineFill = { bg = 'None', fg = 'None' },
        TabLineSel = { bg = 'None' },
        BufferTabpageFill = { bg = 'None', fg = 'None' },
      },
    }
  end,
}
