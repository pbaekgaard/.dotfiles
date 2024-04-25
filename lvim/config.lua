-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.transparent_window = true
lvim.colorscheme = "onedark"
lvim.plugins = {
  { "hrsh7th/nvim-cmp" },
  { "github/copilot.vim" },
  { "ThePrimeagen/vim-be-good" },
  { "navarasu/onedark.nvim" }
}
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

-- ENABLE RELATIVE LINES
vim.opt.relativenumber = true


lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
  local copilot_keys = vim.fn["copilot#Accept"]()
  if cmp.visible() then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    if copilot_keys ~= "" then
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
      fallback()
    end
  end
end

lvim.autocommands = {
  {
    "VimLeave",
    {
      pattern = "*",
      command = "set guicursor= | call chansend(v:stderr, \"\x1b[ q\")"
    }
  }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

lvim.keys.normal_mode["<C-f>"] = ":Telescope live_grep<CR>"

-- format on save
lvim.format_on_save.enabled = true
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { {
  command = "flake8", filetypes = { "python" },
  args = { "--max-line-length", "120" }
} }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "black",
    args = { "--preview", "--enable-unstable-feature", "string_processing", "--line-length", "120" }
  },
  {
    name = "prettier",
    args = { "--print-width", "100" },
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "html", "css", "scss", "markdown" }

  }
}
