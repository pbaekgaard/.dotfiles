return {
  "jakewvincent/mkdnflow.nvim",
  lazy = false,
  config = function()
    require("mkdnflow").setup({
      -- Config goes here; leave blank for defaults
      mappings = {
        MkdnToggleToDo = { { "n", "v" }, "<C-t>" },
        MkdnUpdateNumbering = { "n", "<leader>mn" },
        MkdnTableNewRowBelow = { "n", "<leader>mir" },
        MkdnTableNewRowAbove = { "n", "<leader>miR" },
        MkdnTableNewColAfter = { "n", "<leader>mic" },
        MkdnTableNewColBefore = { "n", "<leader>miC" },
        MkdnFoldSection = { "n", "<leader>mf" },
        MkdnCreateLinkFromClipboard = { "n", "<leader>mp" },
        MkdnUnfoldSection = { "n", "<leader>mF" },
      },
    })
  end,
}
