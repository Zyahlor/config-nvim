return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.pairs").setup({})
      require("mini.comment").setup({})
      require("mini.surround").setup({})

      require("mini.indentscope").setup({
        symbol = "│",
        options = {
          try_as_border = true,
        },
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
    opts = {},
    ft = { "markdown" },
  },
}
