return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        section_separators = "",
        component_separators = "│",
      },
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
}