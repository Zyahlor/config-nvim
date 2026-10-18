return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local custom_theme = {
        normal = {
          a = { fg = "#1a1b26", bg = "#7aa2f7", gui = "bold" }, -- Xanh Dương sáng (Mode)
          b = { fg = "#7dcfff", bg = "#3b4261", gui = "bold" }, -- Chàm / Dark Indigo (Branch)
          c = { fg = "#c0caf5", bg = "#1f2335" },                -- Đêm sâu / Navy Dark (Filename)
          x = { fg = "#db4b4b", bg = "#292e42" },                -- Xám đậm than (Diagnostics)
          y = { fg = "#1a1b26", bg = "#ff9e64", gui = "bold" }, -- Cam hoàng hôn (Filetype / Encoding)
          z = { fg = "#1a1b26", bg = "#bb9af7", gui = "bold" }, -- Tím Neon (Location / Ruler)
        },
        insert = {
          a = { fg = "#1a1b26", bg = "#9ece6a", gui = "bold" }, -- Xanh lá mạ khi gõ code
        },
        visual = {
          a = { fg = "#1a1b26", bg = "#f7768e", gui = "bold" }, -- Đỏ hồng khi chọn khối
        },
        command = {
          a = { fg = "#1a1b26", bg = "#e0af68", gui = "bold" }, -- Vàng hổ phách khi gõ lệnh
        },
        replace = {
          a = { fg = "#1a1b26", bg = "#ff757f", gui = "bold" }, -- Đỏ san hô khi Replace
        },
        inactive = {
          a = { fg = "#565f89", bg = "#1f2335" },
          b = { fg = "#565f89", bg = "#1f2335" },
          c = { fg = "#565f89", bg = "#16161e" },
        },
      }

      return {
        options = {
          theme = custom_theme,
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "neo-tree" } },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = { { "branch", icon = "" } },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = { modified = " 󰷥", readonly = " ", unnamed = "[Không tên]" },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            },
            { "fileformat", icons_enabled = true },
          },
          lualine_y = { "filetype", "encoding" },
          lualine_z = {
            { "progress" },
            { "location", icon = "" },
          },
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
}