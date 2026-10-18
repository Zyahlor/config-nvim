return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Khối màu và mũi tên chuẩn chế độ NORMAL (nền Xanh Dương sáng, chữ đen, kết thúc bằng )
      local arrow_ns = vim.api.nvim_create_namespace("neotree_normal_pill")
      vim.api.nvim_set_hl(0, "NeoTreeNormalPill", { fg = "#1a1b26", bg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeNormalPillArrow", { fg = "#7aa2f7", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "NONE" })

      local function update_neotree_cursor_arrow()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].filetype ~= "neo-tree" then return end
        vim.api.nvim_buf_clear_namespace(buf, arrow_ns, 0, -1)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] - 1
        local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
        if line ~= "" and not line:match("^%s*[A-Za-z]:[/\\]") and not line:match("^%s*󰙅") then
          local s = (line:find("%S") or 1) - 1
          -- Đổi màu toàn bộ khối chữ và icon sang nền Xanh Dương, CHỮ ĐEN ĐẬM chuẩn NORMAL (priority 4096)
          pcall(vim.api.nvim_buf_set_extmark, buf, arrow_ns, row, s, {
            end_col = #line,
            hl_group = "NeoTreeNormalPill",
            priority = 4096,
          })
          -- Đặt mũi tên nhọn  ở ngay đuôi của tên file
          pcall(vim.api.nvim_buf_set_extmark, buf, arrow_ns, row, #line, {
            virt_text = { { "", "NeoTreeNormalPillArrow" } },
            virt_text_pos = "inline",
            priority = 4096,
          })
        end
      end

      local arrow_group = vim.api.nvim_create_augroup("NeoTreeCursorArrowMarker", { clear = true })
      vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
        group = arrow_group,
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "neo-tree" then
            vim.schedule(update_neotree_cursor_arrow)
          end
        end,
      })

      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 30,
          mappings = {
            ["<cr>"] = "open",
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            hide_dotfiles = false,
          },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", {
        desc = "Bật/Tắt cây thư mục",
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
      require("oil").setup()

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
        desc = "Mở thư mục hiện tại",
      })
    end,
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)

      vim.keymap.set("n", "<leader>ff", fzf.files, {
        desc = "Tìm file",
      })

      vim.keymap.set("n", "<leader>fg", fzf.live_grep, {
        desc = "Tìm chữ trong project",
      })

      vim.keymap.set("n", "<leader>ss", fzf.lsp_document_symbols, {
        desc = "Tìm Heading/Hàm",
      })
    end,
  },

  {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        layout = {
          default_direction = "right",
          width = 32,
        },
      })

      vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle! right<cr>", {
        desc = "Bật/Tắt Outline",
      })
    end,
  },
}
