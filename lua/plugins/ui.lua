return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local custom_theme = {
        normal = {
          a = { fg = "#1a1b26", bg = "#7aa2f7", gui = "bold" }, -- Xanh Dương sáng (Mode / Tab Active)
          b = { fg = "#7dcfff", bg = "#3b4261", gui = "bold" }, -- Chàm / Dark Indigo (Branch / Tab Inactive)
          c = { fg = "#c0caf5", bg = "#1f2335" },                -- Đêm sâu / Navy Dark (Filename)
          x = { fg = "#db4b4b", bg = "#292e42" },                -- Xám đậm than (Diagnostics)
          y = { fg = "#1a1b26", bg = "#ff9e64", gui = "bold" }, -- Cam hoàng hôn (Filetype / Encoding)
          z = { fg = "#1a1b26", bg = "#bb9af7", gui = "bold" }, -- Tím Neon (Location / Ruler)
        },
        insert = {
          a = { fg = "#1a1b26", bg = "#9ece6a", gui = "bold" },
        },
        visual = {
          a = { fg = "#1a1b26", bg = "#f7768e", gui = "bold" },
        },
        command = {
          a = { fg = "#1a1b26", bg = "#e0af68", gui = "bold" },
        },
        replace = {
          a = { fg = "#1a1b26", bg = "#ff757f", gui = "bold" },
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
        tabline = {
          lualine_a = {
            {
              "buffers",
              show_modified_status = true,
              mode = 0,
              symbols = {
                modified = " ●",
                alternate_file = "",
                directory = "",
              },
              buffers_color = {
                active = { fg = "#1a1b26", bg = "#7aa2f7", gui = "bold" },   -- Tab đang chọn: Giống hệt khối NORMAL
                inactive = { fg = "#7dcfff", bg = "#3b4261", gui = "bold" }, -- Tab kế bên: Giống hệt khối main
              },
            },
          },
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