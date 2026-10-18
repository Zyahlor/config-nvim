return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    opts = {
      size = 15,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = false,
      shell = (function()
        if vim.fn.has("win32") == 1 then
          if vim.fn.executable("pwsh") == 1 then
            return "pwsh -NoLogo"
          elseif vim.fn.executable("powershell") == 1 then
            return "powershell -NoLogo"
          end
        end
        return vim.o.shell
      end)(),
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local map = vim.keymap.set

      -- Phím tắt Bật / Tắt Terminal dưới đáy (gán cứng <Ctrl + \>)
      map({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Bật/Tắt Terminal dưới đáy" })

      -- Thao tác phím bên trong Terminal:
      -- Bấm Esc Esc để về Normal mode; bấm 'q' hoặc 'Esc' ở Normal mode là ĐÓNG NGAY terminal
      local term_group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("TermOpen", {
        group = term_group,
        pattern = "term://*toggleterm#*",
        callback = function(event)
          local buf_opts = { buffer = event.buf, silent = true }
          map("t", "<Esc><Esc>", [[<C-\><C-n>]], buf_opts)
          map("t", "<C-\\>", "<cmd>ToggleTerm<cr>", buf_opts)
          map("n", "q", "<cmd>close<cr>", buf_opts)
          map("n", "<Esc>", "<cmd>close<cr>", buf_opts)
        end,
      })

      -- Chạy code 1 chạm (F5) HIỂN THỊ DƯỚI ĐÁY
      local run_code = function()
        local ft = vim.bo.filetype
        local file_path = vim.fn.expand("%:p")
        if file_path == "" then
          vim.notify("Không có file nào đang mở để chạy!", vim.log.levels.WARN)
          return
        end

        local file_dir = vim.fn.expand("%:p:h")
        local file_name = vim.fn.expand("%:t")
        local bin_name = vim.fn.expand("%:t:r")
        local is_win = vim.fn.has("win32") == 1

        -- Lưu file trước khi chạy
        vim.cmd("silent! write")

        local cpp_compiler = (vim.fn.executable("g++") == 1 and "g++") or (vim.fn.executable("clang++") == 1 and "clang++") or nil
        local c_compiler = (vim.fn.executable("gcc") == 1 and "gcc") or (vim.fn.executable("clang") == 1 and "clang") or nil

        local cmd = ""
        if ft == "cpp" then
          if not cpp_compiler then
            vim.notify("Không tìm thấy g++ hoặc clang++ trên máy!", vim.log.levels.ERROR)
            return
          end
          if is_win then
            cmd = string.format('%s -O2 -Wall "%s" -o "%s.exe" && ".\\%s.exe"', cpp_compiler, file_name, bin_name, bin_name)
          else
            cmd = string.format('%s -O2 -Wall "%s" -o "%s" && ./"%s"', cpp_compiler, file_name, bin_name, bin_name)
          end
        elseif ft == "c" then
          if not c_compiler then
            vim.notify("Không tìm thấy gcc hoặc clang trên máy!", vim.log.levels.ERROR)
            return
          end
          if is_win then
            cmd = string.format('%s -O2 -Wall "%s" -o "%s.exe" && ".\\%s.exe"', c_compiler, file_name, bin_name, bin_name)
          else
            cmd = string.format('%s -O2 -Wall "%s" -o "%s" && ./"%s"', c_compiler, file_name, bin_name, bin_name)
          end
        elseif ft == "python" then
          cmd = is_win and string.format('python "%s"', file_name) or string.format('python3 "%s"', file_name)
        elseif ft == "sh" or ft == "bash" then
          cmd = string.format('bash "%s"', file_name)
        else
          vim.notify("Chưa hỗ trợ chạy trực tiếp định dạng: " .. ft, vim.log.levels.WARN)
          return
        end

        local terms = require("toggleterm.terminal")
        local Terminal = terms.Terminal

        -- Xóa tiến trình/cửa sổ runner cũ nếu đang tồn tại để F5 lần nào cũng là chạy mới hoàn toàn
        local old_runner = terms.get(5, true)
        if old_runner then
          old_runner:shutdown()
        end

        local runner = Terminal:new({
          cmd = cmd,
          dir = file_dir,
          direction = "horizontal",
          count = 5,
          close_on_exit = false,
        })
        runner:open(15, "horizontal")
      end

      map("n", "<F5>", run_code, { desc = "Biên dịch & Chạy code ở thanh dưới (F5)" })
      map("n", "<leader>rr", run_code, { desc = "Biên dịch & Chạy code ở thanh dưới" })
    end,
  },
}
