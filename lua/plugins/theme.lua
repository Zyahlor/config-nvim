return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { bold = true },
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.Type = { fg = c.blue1, bold = true }
        hl.Statement = { fg = c.magenta, bold = true }
        hl["@type"] = { fg = c.blue1, bold = true }
        hl["@keyword"] = { fg = c.magenta, bold = true }
        hl["@function"] = { fg = c.blue, bold = true }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
}
