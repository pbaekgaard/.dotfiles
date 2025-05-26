return {
  'folke/zen-mode.nvim',
  lazy = false,
  opts = {
    window = {
      backdrop = 1,
      width = 0.80,
      height = 0.98,
      options = {
        number = false,
        cursorline = true,
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        laststatus = 0,
      },
      twilight = { enabled = false },
      todo = { enabled = true },
      tmux = { enabled = false },
      -- your configuration comes here
    },
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
