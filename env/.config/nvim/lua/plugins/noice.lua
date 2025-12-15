return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.presets.lsp_doc_border = true
    opts.presets.bottom_search = true

    -- Disable both cmdline and messages to see default cmdline
    opts.cmdline = opts.cmdline or {}
    opts.cmdline.enabled = false

    opts.messages = opts.messages or {}
    opts.messages.enabled = false
  end,
}
