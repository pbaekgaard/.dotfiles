return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      float = {
        padding = 2,
        max_width = 160,
        min_width = 90,
        width = nil,
        -- max_height = 0,
        -- min_width = 50,
      },
      preview = {
        max_width = 0.90,
        min_width = 0.7,
        width = nil,
        border = "rounded",
        update_on_cursor_moved = true,
      },
      win_options = {
        wrap = true,
        winblend = 0,
        winhl = "Normal:Normal,Normal:Normal",
      },
      keymaps = {
        ["<C-c>"] = false,
        ["q"] = "actions.close",
      },
    })
    vim.keymap.set("n", "<leader>e", function()
      oil = require("oil")
      oil.open_float()
    end, { desc = "[E]xplore Files" })
  end,
}
