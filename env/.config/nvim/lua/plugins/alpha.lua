return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-mini/mini.icons",
    },
    config = function()
      require("config.alpha")
    end,
  },
}
