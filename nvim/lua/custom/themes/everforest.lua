return {
  'sainnhe/everforest',

  lazy = true,
  priority = 1000,
  config = function()
    vim.g.everforest_enable_italic = true
    vim.g.everforest_transparent_background = 2
    -- vim.g.everforest_style = 'med'
    vim.g.everforest_diagnostic_text_highlight = 1
    vim.g.everforest_diagnostic_line_highlight = 1
    vim.g.everforest_diagnostic_virtual_text = 'colored'
    -- vim.cmd 'hi CursorLine guibg=#333648'
    -- vim.cmd 'hi CursorLineNr guibg=#333648 guifg=#77d5f0'
    vim.cmd 'hi BufferTabpageFill guibg=  guifg= '
  end,
}
