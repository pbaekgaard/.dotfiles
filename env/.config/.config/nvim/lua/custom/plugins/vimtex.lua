return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    -- Set the PDF viewer to Zathura
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_view_forward_search_on_start = 0
    vim.g.vimtex_mappings_prefix = '<localleader>v'
    -- Configure Latexmk
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = './.latexmk/aux',
      out_dir = './compiled',
      callback = 1,
      continuous = 1,
      options = {
        '-shell-escape',
        -- '-verbose',
        -- '-file-line-error',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }
  end,
}
