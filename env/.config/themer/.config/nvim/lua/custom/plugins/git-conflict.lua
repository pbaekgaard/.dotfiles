vim.cmd "highlight DiffAdd guibg = '#405d7e'"
vim.cmd "highlight DiffText guibg = '#314753'"
return {
  'akinsho/git-conflict.nvim',
  version = '*',
  opts = {
    default_mappings = false,
    disable_diagnostics = true,
    list_opener = 'copen',
    highlights = {
      incoming = 'DiffAdd',
      current = 'DiffText',
    },
  },
}
