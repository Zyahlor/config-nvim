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
      -- Định nghĩa màu cho mũi tên Lualine trên file đang chọn trong cây thư mục
      local arrow_ns = vim.api.nvim_create_namespace("neotree_arrow_cursor")
      vim.api.nvim_set_hl(0, "NeoTreeActiveArrow", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#24283b", bold = true })

      local function update_neotree_cursor_arrow()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].filetype ~= "neo-tree" then return end
        vim.api.nvim_buf_clear_namespace(buf, arrow_ns, 0, -1)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] - 1
        local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
        if line ~= "" and not line:match("^%s*[A-Za-z]:[/\\]") and not line:match("^%s*󰙅") then
          pcall(vim.api.nvim_buf_set_extmark, buf, arrow_ns, row, 0, {
            virt_text = { { " ", "NeoTreeActiveArrow" } },
            virt_text_pos = "eol",
            hl_mode = "combine",
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

      local function get_active_editor_file()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft ~= "neo-tree" and ft ~= "" then
            return vim.fs.normalize(vim.api.nvim_buf_get_name(buf))
          end
        end
        return ""
      end

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
          components = {
            lualine_arrow = function(config, node, state)
              local active_file = get_active_editor_file()
              if active_file ~= "" and vim.fs.normalize(node.path) == active_file then
                return {
                  text = " ",
                  highlight = "NeoTreeActiveArrow",
                }
              end
              return {}
            end,
          },
        },
        renderers = {
          file = {
            { "indent" },
            { "icon" },
            {
              "name",
              use_git_status_colors = true,
              zindex = 10,
            },
            { "lualine_arrow", zindex = 15 },
            { "diagnostics", errors_only = true, zindex = 20 },
            { "git_status", zindex = 20 },
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
