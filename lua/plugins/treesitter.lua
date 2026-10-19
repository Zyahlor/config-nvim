return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      ts.setup({
        ensure_installed = {
          "c",
          "cpp",
          "python",
          "lua",
          "bash",
          "markdown",
          "markdown_inline",
          "html",
          "css",
          "javascript",
          "typescript",
          "php",
          "go",
          "gomod",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
