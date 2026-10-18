return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and "  " or "  "
          return icon .. count
        end,
        always_show_bufferline = true,
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        modified_icon = "●",
        indicator = {
          style = "none",
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "󰙅 CÂY THƯ MỤC",
            text_align = "center",
            highlight = "Directory",
            separator = true,
          },
        },
      },
      highlights = {
        fill = {
          bg = "#16161e",
        },
        background = {
          fg = "#a9b1d6",
          bg = "#1f2335",
        },
        buffer_selected = {
          fg = "#1a1b26",
          bg = "#7aa2f7",
          bold = true,
          italic = false,
        },
        buffer_visible = {
          fg = "#c0caf5",
          bg = "#1f2335",
        },
        separator_selected = {
          fg = "#7aa2f7",
          bg = "#16161e",
        },
        separator_visible = {
          fg = "#1f2335",
          bg = "#16161e",
        },
        separator = {
          fg = "#1f2335",
          bg = "#16161e",
        },
        modified_selected = {
          fg = "#1a1b26",
          bg = "#7aa2f7",
        },
        modified = {
          fg = "#ff9e64",
          bg = "#1f2335",
        },
        modified_visible = {
          fg = "#ff9e64",
          bg = "#1f2335",
        },
      },
    },
    config = function(_, opts)
      -- Định nghĩa ký tự kết thúc tab là hình mũi tên nhọn Powerline  giống hệt Lualine
      local constants = require("bufferline.constants")
      constants.sep_chars.slant = { "", "" }

      require("bufferline").setup(opts)

      -- Phím tắt chuyển tab & quản lý buffer
      local map = vim.keymap.set
      map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Tab kế tiếp" })
      map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Tab trước đó" })
      map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Đóng tab hiện tại" })
      map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Đóng các tab khác" })
      map("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Ghim tab" })
      map("n", "<leader>bpk", "<cmd>BufferLinePick<cr>", { desc = "Chọn nhanh tab theo chữ cái" })
    end,
  },
}
