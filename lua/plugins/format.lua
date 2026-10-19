return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          c = { "clang_format" },
          cpp = { "clang_format" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          php = { "prettier" },
          go = { "gofmt" },
        },
      })

      local format_func = function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end

      vim.keymap.set({ "n", "v" }, "<leader>fm", format_func, { desc = "Định dạng code (Format)" })
      vim.keymap.set({ "n", "v" }, "<leader>cf", format_func, { desc = "Định dạng code (Format)" })
    end,
  },
}
