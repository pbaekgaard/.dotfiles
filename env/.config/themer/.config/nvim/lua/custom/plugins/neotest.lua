return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'orjangj/neotest-ctest',
    'alfaix/neotest-gtest',
    'alfaix/neotest-gtest',
  },
  keys = function()
    local neotest = require 'neotest'
    return {
      {
        '<leader>tf',
        function()
          neotest.run.run(vim.fn.expand '%')
        end,
        desc = 'Run File',
      },
      {
        '<leader>tn',
        function()
          neotest.run.run()
        end,
        desc = 'Run Nearest',
      },
      {
        '<leader>tw',
        function()
          neotest.run.run(vim.loop.cwd())
        end,
        desc = 'Run Workspace',
      },
      {
        '<leader>tr',
        function()
          -- This will only show the output from the test framework
          neotest.output.open { short = true, auto_close = true }
        end,
        desc = 'Results (short)',
      },
      {
        '<leader>tR',
        function()
          -- This will show the classic CTest log output.
          -- The output usually spans more than can fit the neotest floating window,
          -- so using 'enter = true' to enable normal navigation within the window
          -- is recommended.
          neotest.output.open { enter = true }
        end,
        desc = 'Results (full)',
      },
      -- Other keybindings
    }
  end,
  opts = function(_, opts)
    opts = opts or {}
    opts.consumers = opts.consumers or {}
    opts.consumers.overseer = require 'neotest.consumers.overseer'
  end,
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Convert newlines, tabs and whitespaces into a single whitespace
          -- for improved virtual text readability
          local message = diagnostic.message:gsub('[\r\n\t%s]+', ' ')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup {
      adapters = {
        require('neotest-gtest').setup {},
      },
    }
  end,
}
