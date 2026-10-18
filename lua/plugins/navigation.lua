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
