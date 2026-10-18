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
        separator_style = "slant", -- Kiểu vát chéo nghiêng hiện đại, đồng bộ với lualine
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
        modified_icon = "●",
        indicator = {
          icon = "▎",
          style = "icon",
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
        buffer_selected = {
          bold = true,
          italic = false,
        },
      },
    },
    config = function(_, opts)
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
