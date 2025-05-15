return {
  {
    'akinsho/toggleterm.nvim',
    cmd = { 'ToggleTerm' },

    opts = {
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_mode = false,
      size = function(term)
        if term.direction == 'horizontal' then
          return vim.o.lines * 0.4
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        else
          return 15
        end
      end,
      float_opts = {
        border = 'curved',
      },
    },
  },
}
