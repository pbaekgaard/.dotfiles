return {
  'sainnhe/sonokai',
  lazy = true,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.sonokai_enable_italic = true
    vim.g.sonokai_transparent_background = 2
    vim.g.sonokai_style = 'andromeda'
    vim.g.sonokai_diagnostic_text_highlight = 1
    vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_diagnostic_virtual_text = 'colored'
    vim.cmd 'hi CursorLine guibg=#333648'
    vim.cmd 'hi CursorLineNr guibg=#333648 guifg=#77d5f0'
    vim.cmd 'hi BufferTabpageFill guibg=  guifg= '
  end,
}
