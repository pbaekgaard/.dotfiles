return {
  name = 'Run CTests',
  builder = function()
    return {
      cmd = { 'ctest' }, -- Fix: cmd should be a table
      args = { '--output-on-failure', '--test-dir', 'build' },
      strategy = { 'toggleterm' }, -- Fix: strategy should be a table
      components = {
        { 'on_output_quickfix', open = false },
        'default',
      },
    }
  end,
  condition = {
    callback = function()
      -- Check if `ctest` is installed
      local ctest_exists = vim.fn.executable 'ctest' == 1

      -- Check if "ctest" appears in CMakeLists.txt
      local has_ctest = #vim.fn.systemlist "grep 'ctest' CMakeLists.txt" > 0

      return ctest_exists and has_ctest
    end,
    filetype = { 'cpp', 'c' },
  },
}
