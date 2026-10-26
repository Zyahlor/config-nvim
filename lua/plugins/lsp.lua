return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      vim.o.winborder = "rounded"

      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })

      -- Custom root_dir cho marksman
      vim.lsp.config("marksman", {
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          on_dir(vim.fs.root(fname, { ".git", ".marksman.toml" }) or vim.fs.dirname(fname))
        end,
      })

      -- Custom cmd cho clangd để nhận diện thư viện chuẩn C++ từ MSYS2 / GCC
      -- Tắt hoàn toàn tự động chèn thư viện vào đầu file (--header-insertion=never)
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--header-insertion-decorators=0",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--query-driver=C:/msys64/ucrt64/bin/g++.exe,C:/msys64/ucrt64/bin/gcc.exe,**/*g++*,**/*gcc*",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "marksman",
          "clangd",
          "pyright",
          "html",
          "cssls",
          "ts_ls",
          "intelephense",
          "gopls",
        },
      })
    end,
  },
}
