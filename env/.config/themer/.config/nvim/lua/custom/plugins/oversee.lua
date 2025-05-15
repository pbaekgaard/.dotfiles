return {
  'stevearc/overseer.nvim',
  cmd = {
    'OverseerOpen',
    'OverseerClose',
    'OverseerToggle',
    'OverseerSaveBundle',
    'OverseerLoadBundle',
    'OverseerDeleteBundle',
    'OverseerRunCmd',
    'OverseerRun',
    'OverseerInfo',
    'OverseerBuild',
    'OverseerQuickAction',
    'OverseerTaskAction',
    'OverseerClearCache',
  },
  opts = {
    dap = false,
    strategy = { name = 'toggleterm', direction = 'horizontal' },
    task_list = {
      bindings = {
        ['<C-h>'] = false,
        ['<C-j>'] = false,
        ['<C-k>'] = false,
        ['<C-l>'] = false,
      },
    },
    form = {
      win_opts = {
        winblend = 0,
      },
    },
    confirm = {
      win_opts = {
        winblend = 0,
      },
    },
    task_win = {
      win_opts = {
        winblend = 0,
      },
    },
  },
  config = function()
    require('overseer').setup {
      templates = { 'builtin' },
    }
  end,
  -- stylua: ignore
  keys = {
    { "<leader>ol", "<cmd>OverseerToggle<cr>",      desc = "Task [l]ist" },
    { "<leader>or", "<cmd>OverseerRun<cr>",         desc = "[R]un task" },
    { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
    { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer [I]nfo" },
    { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task [b]uilder" },
    { "<leader>oa", "<cmd>OverseerTaskAction<cr>",  desc = "Task [a]ction" },
    { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "[C]lear cache" },
    { "<leader>ot", "<cmd>OverseerToggle<cr>",  desc = "[T]oggle Console" },
  },
}
