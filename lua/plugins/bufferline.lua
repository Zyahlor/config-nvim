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
        always_show_bufferline = true,
        separator_style = "thin", -- "slant" | "slope" | "thick" | "thin"
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "󰙅 File Explorer",
            text_align = "center",
            separator = true,
          },
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
    end,
  },
}
